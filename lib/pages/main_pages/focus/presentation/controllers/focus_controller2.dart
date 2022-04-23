import 'dart:async';
import 'dart:convert';

import 'package:common/constants/argument_keys.dart';
import 'package:common/controller/base_controller.dart';
import 'package:common/utils/time_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:getx/getx.dart';
import 'package:local_notification/local_notification.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:sensor_plugin/sensor_plugin.dart';
import 'package:vibrate_plugin/vibrate_plugin.dart';

import '../../../../../routes/app_pages.dart';
import '../../focus.dart';

enum Status {
  show_button,
  hide_button,
}

enum NotificationPayload {
  finishFocus,
  backToFocus,
}

class FocusController extends BaseController {
  FocusController({required final this.focusRepository});

  final IFocusRepository focusRepository;

  final _service = FlutterBackgroundService();

  double screenBrightness = 0.1;

  // 获取传感器的值
  StreamSubscription<dynamic>? _streamSubscription;

  // 记录手机姿态角度的计时器
  Timer? _sensorTimer;

  // 当前手机姿态角度，手机平放为-90
  double _angleX = 0;

  // 记录手机姿态角度
  double _angleXPre = 0;

  // 每隔一定时间记录传感器的值
  final sensorTime = 800;

  //当前的计时状态
  final currentStatus = Status.hide_button.obs;

  //倒计时总时间
  final staticTime = 25 * 60;

  //倒计时剩余时间
  final countDown = 0.obs;

  //UI显示的时间
  final time = ''.obs;

  //中断时间
  static const interruptTime = 5;

  bool? isInBackGround;

  final circleProgressValue = 0.0.obs;

  //长按倒计时
  Timer? _longPressTimer;

  //显示长按按钮
  Future<void> showButton({required final bool isPress}) async {
    currentStatus.value = Status.show_button;
    _service
      ..invoke('stopHideButtonTimer')
      ..invoke('startHideButtonTimer')
      ..on('hideButton').listen((final event) {
        if (event != null && event['tick'] == 5) {
          hideButton();
        }
      });
    if (isPress) {
      _longPressTimer =
          Timer.periodic(const Duration(milliseconds: 10), (final timer) {
        circleProgressValue.value += 10 / 900;
      });
    }
    await ScreenBrightness.resetScreenBrightness();
  }

  void cancelLongPressTimer() {
    _longPressTimer?.cancel();
    circleProgressValue.value = 0.0;
  }

  //隐藏长按按钮
  Future<void> hideButton() async {
    currentStatus.value = Status.hide_button;
    await ScreenBrightness.setScreenBrightness(screenBrightness);
  }

  void gotoNextPage() {
    final arguments = {
      ArgumentKeys.focusTime: TimeUtil.convertTimeToText(
        (staticTime - countDown.value) ~/ 60,
        (staticTime - countDown.value) % 60,
      ),
    };
    Get.offNamed(Routes.result, arguments: arguments);
  }

  void goBack() {
    disposeAll();
    Get.back();
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    _initTimer();
    _initSensor();
  }

  void _initTimer() {
    countDown.value = staticTime;
    time.value =
        TimeUtil.convertTime(countDown.value ~/ 60, countDown.value % 60);
    _service
      ..invoke('startFocusCountDownTimer')
      ..on('focusCountDown').listen((final event) {
        if (event == null) {
          return;
        }
        countDown.value = staticTime - event['tick'] as int;
        time.value =
            TimeUtil.convertTime(countDown.value ~/ 60, countDown.value % 60);
        if (countDown.value == 0) {
          if (isInBackGround ?? false) {
            sendFinishFocusMsg();
          }
          gotoNextPage();
        }
      });
  }

  void _initSensor() {
    _sensorTimer = Timer.periodic(
      Duration(milliseconds: sensorTime),
      (final timer) {
        if (_angleX < 0 && (_angleX - _angleXPre > 20 || _angleXPre > 0)) {
          // 抬起手机发出震动警告并显示放弃按钮，倒计时继续
          VibratePlugin.vibrateWithPauses([
            const Duration(milliseconds: 1000),
            const Duration(milliseconds: 1000),
          ]);
          showButton(isPress: false);
          // _sensorTimer.cancel();
          // _streamSubscription.cancel();
        }
        _angleXPre = _angleX;
      },
    );
    _streamSubscription = SensorPlugin.stream().listen((final event) {
      _angleX = jsonDecode(event)['X'].toDouble();
      // debugPrint('$_angleX');
    });
  }

  @override
  Future<void> onPaused() async {
    super.onPaused();
    isInBackGround = true;
    await _streamSubscription?.cancel();
    _sensorTimer?.cancel();
    if (countDown.value <= interruptTime * 2 + 1) {
      // 为了避免后退到app主页和进入休息页的倒计时发生冲突，在这里做个判断
      // 即如果剩余专注时间小于interruptTime的两倍，则不做任何中断专注逻辑的判断
      return;
    }
    // 锁屏或者app进入后台时触发
    final brightness = await ScreenBrightness.currentBrightness;
    if (brightness == 0.0) {
      //锁屏，倒计时继续
    } else {
      //app进入后台
      await sendBackToFocusMsg(interruptTime);
      _service
        ..invoke('startFocusPageBackgroundTimer')
        ..on('focusPageBackground').listen((final event) async {
          if (event == null) {
            return;
          }
          final brightness = await ScreenBrightness.currentBrightness;
          if (event['tick'] < interruptTime && brightness == 0.0) {
            //app进入后台并且在5s内锁屏，倒计时继续并取消通知
            _service
              ..invoke('stopFocusPageBackgroundTimer')
              ..invoke('stopFocusPageSendMsgTimer');
            await NotificationService()
                .cancelNotification(NotificationPayload.backToFocus.index);
          } else if (event['tick'] >= interruptTime && brightness != 0.0) {
            //app进入后台并且亮屏超过5s，立即发消息通知
            _service.invoke('stopFocusPageBackgroundTimer');
          }
        })
        // 消息通知5s后，没回到专注鱼，退出专注-退回到APP主页
        ..invoke('startFocusPageSendMsgTimer')
        ..on('focusPageSendMsg').listen((final event) {
          if (event != null && event['tick'] == interruptTime * 2) {
            goBack();
          }
        });
    }
  }

  Future<void> sendBackToFocusMsg(final int delay) async {
    await NotificationService().zonedScheduleNotification(
      NotificationPayload.backToFocus.index,
      '专注鱼',
      '立即点击此处回到专注鱼，以免中断专注。',
      NotificationPayload.backToFocus.toString(),
      delay,
    );
  }

  Future<void> sendFinishFocusMsg() async {
    await NotificationService().showNotification(
      NotificationPayload.finishFocus.index,
      '专注鱼',
      '恭喜你完成了25分钟专注，休息一下吧。',
      NotificationPayload.finishFocus.toString(),
    );
  }

  @override
  void onResumed() {
    super.onResumed();
    isInBackGround = false;
    _initSensor();
    _service
      ..invoke('stopFocusPageSendMsgTimer')
      ..invoke('stopFocusPageBackgroundTimer');
  }

  @override
  void onClose() {
    disposeAll();
    super.onClose();
  }

  void disposeAll() {
    _streamSubscription?.cancel();
    _sensorTimer?.cancel();
    _service
      ..invoke('stopFocusCountDownTimer')
      ..invoke('stopHideButtonTimer')
      ..invoke('stopFocusPageSendMsgTimer')
      ..invoke('stopFocusPageBackgroundTimer');
    _longPressTimer?.cancel();
    NotificationService()
        .cancelNotification(NotificationPayload.backToFocus.index);
  }
}
