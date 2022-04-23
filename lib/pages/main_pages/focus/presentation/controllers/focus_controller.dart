import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:common/constants/argument_keys.dart';
import 'package:common/controller/base_controller.dart';
import 'package:common/utils/sp_utils/sp_utils.dart';
import 'package:common/utils/time_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:getx/getx.dart';
import 'package:intl/intl.dart';
import 'package:local_notification/local_notification.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:sensor_plugin/sensor_plugin.dart';
import 'package:torch_light/torch_light.dart';
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

  final String fadeImage = Get.arguments[ArgumentKeys.focusFadeImage];

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

  //倒计时是否已开始
  bool? _countDownTimerStarted;

  final plusTime = false.obs;

  // 过场动画的计时器
  Timer? animateTimer;

  // 过场动画的持续时间
  final int animateTime = 3;

  // 过场动画的剩余时间
  int animateRemainTime = 0;

  final animateTimerFinish = false.obs;

  // 中断的计时器
  Timer? interruptTimer;

  //显示长按按钮
  Future<void> showButton({required final bool isPress}) async {
    currentStatus.value = Status.show_button;
    _service
      ..invoke('stopHideButtonTimer')
      ..invoke('startHideButtonTimer')
      ..on('hideButton').listen((final event) async {
        if (event == null) {
          return;
        }
        if (event['tick'] >= 5) {
          if (currentStatus.value == Status.show_button) {
            // 有可能是退到后台再回来，此时currentStatus已经是hide_button
            hideButton();
            await ScreenBrightness.setScreenBrightness(screenBrightness);
          }
          _service.invoke('stopHideButtonTimer');
        }
      });
    if (isPress) {
      _longPressTimer =
          Timer.periodic(const Duration(milliseconds: 10), (final timer) {
        circleProgressValue.value += 10 / 1000;
        if (circleProgressValue.value >= 1) {
          goBack();
          timer.cancel();
        }
      });
    }
    await ScreenBrightness.resetScreenBrightness();
  }

  void cancelLongPressTimer() {
    _longPressTimer?.cancel();
    circleProgressValue.value = 0.0;
  }

  //隐藏长按按钮
  void hideButton() {
    currentStatus.value = Status.hide_button;
  }

  ///开始中断
  Future<void> _startInterrupt() async {
    interruptTimer =
        Timer.periodic(const Duration(milliseconds: 500), (final timer) {
      if (timer.tick >= 3) {
        _stopInterrupt();
        timer.cancel();
      }
    });
    _stopCountDownTimer();
    //如果中断时间立马+1
    plusTime.value = true;
    setCountDownValue(countDown.value + 1);
    await _enableTorch();
    Future.delayed(const Duration(milliseconds: 500), () async {
      await _disableTorch();
    });
  }

  ///结束中断
  void _stopInterrupt() {
    plusTime.value = false;
    if (!(_countDownTimerStarted ?? false)) {
      _startCountDown(countDown.value);
    }
  }

  void gotoNextPage() {
    disposeAll();
    NotificationService()
        .cancelNotification(NotificationPayload.backToFocus.index);
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
    NotificationService().cancelAllNotifications();
    Get.back();
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    //记录专注休息开始时间
    SPUtils.getInstance().setRestStartTimeTemp(
      restStartTime: DateFormat('MM-dd HH:mm').format(DateTime.now()),
    );
    animateTimer = Timer.periodic(const Duration(seconds: 1), (final timer) {
      animateRemainTime =
          animateTime - timer.tick < 0 ? 0 : animateTime - timer.tick;
      if (timer.tick >= animateTime) {
        timer.cancel();
        animateTimerFinish.value = true;
        _initTimer(timer.tick - animateTime);
        _initSensor();
      }
    });
  }

  void setCountDownValue(final int value) {
    countDown.value = value;
    time.value =
        TimeUtil.convertTime(countDown.value ~/ 60, countDown.value % 60);
  }

  ///passedTime：如果在过渡动画时息屏或者退到后台，记录已过的时间，在初始时间上减去该时间
  void _initTimer(final int passedTime) {
    setCountDownValue(staticTime - passedTime);
    _startCountDown(staticTime - passedTime);
  }

  void _startCountDown(final curTime) {
    _countDownTimerStarted = true;
    NotificationService()
        .cancelNotification(NotificationPayload.finishFocus.index);
    sendFinishFocusMsg(countDown.value);
    _service
      ..invoke('startFocusCountDownTimer')
      ..on('focusCountDown').listen((final event) {
        if (event == null) {
          return;
        }
        setCountDownValue(curTime - event['tick'] as int);
        if (countDown.value <= 0) {
          _service.invoke('stopFocusCountDownTimer');
          if (!(isInBackGround ?? false)) {
            //如果在前台取消通知
            NotificationService()
                .cancelNotification(NotificationPayload.finishFocus.index);
          }
          gotoNextPage();
        }
      });
  }

  void _stopCountDownTimer() {
    _countDownTimerStarted = false;
    _service.invoke('stopFocusCountDownTimer');
  }

  void _initSensor() {
    _sensorTimer = Timer.periodic(
      Duration(milliseconds: sensorTime),
      (final timer) {
        if (_angleX < 0 && (_angleX - _angleXPre > 20 || _angleXPre > 0)) {
          // 抬起手机发出震动警告并显示放弃按钮，倒计时继续
          showButton(isPress: false);
          _startInterrupt();
          VibratePlugin.vibrateWithPauses([
            const Duration(milliseconds: 1000),
            const Duration(milliseconds: 1000),
          ]);
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
    if (animateTimerFinish.value) {
      //过渡动画播放完成
      await _streamSubscription?.cancel();
      _sensorTimer?.cancel();
      hideButton();
    }
    // if (countDown.value <= interruptTime * 2 + 1) {
    //   // 为了避免后退到app主页和进入休息页的倒计时发生冲突，在这里做个判断
    //   // 即如果剩余专注时间小于interruptTime的两倍，则不做任何中断专注逻辑的判断
    //   return;
    // }
    // 锁屏或者app进入后台时触发
    bool isLocked;
    if (Platform.isAndroid) {
      isLocked = await ScreenBrightness.isScreenLocked;
    } else {
      final brightness = await ScreenBrightness.currentBrightness;
      isLocked = brightness == 0.0;
    }
    if (isLocked) {
      //锁屏，倒计时继续
    } else {
      //app进入后台
      sendBackToFocusMsg(interruptTime + animateRemainTime);
      if (Platform.isAndroid) {
        _service
          ..invoke('startFocusPageBackgroundTimer')
          ..on('focusPageBackground').listen((final event) async {
            if (event == null) {
              return;
            }
            final isLocked = await ScreenBrightness.isScreenLocked;
            if (event['tick'] < interruptTime && isLocked) {
              //app进入后台并且在5s内锁屏，倒计时继续并取消通知
              _service
                ..invoke('stopFocusPageBackgroundTimer')
                ..invoke('stopFocusPageSendMsgTimer');
              await NotificationService()
                  .cancelNotification(NotificationPayload.backToFocus.index);
            } else if (event['tick'] >= interruptTime && !isLocked) {
              //app进入后台并且亮屏超过5s，立即发消息通知
              _service.invoke('stopFocusPageBackgroundTimer');
            }
          });
      }
      _service
        // 消息通知5s后，没回到专注鱼，退出专注-退回到APP主页
        ..invoke('startFocusPageSendMsgTimer')
        ..on('focusPageSendMsg').listen((final event) {
          if (event == null) {
            return;
          }
          if (event['tick'] > interruptTime * 2 + animateRemainTime) {
            _service.invoke('stopFocusPageSendMsgTimer');
            goBack();
          }
        });
    }
  }

  void sendBackToFocusMsg(final int delay) {
    NotificationService().zonedScheduleNotification(
      NotificationPayload.backToFocus.index,
      '专注鱼',
      '立即点击此处回到专注鱼，以免中断专注。',
      NotificationPayload.backToFocus.toString(),
      delay,
    );
  }

  void sendFinishFocusMsg(final int delay) {
    NotificationService().zonedScheduleNotification(
      NotificationPayload.finishFocus.index,
      '专注鱼',
      '恭喜你完成了25分钟专注，休息一下吧。',
      NotificationPayload.finishFocus.toString(),
      delay + 1, //发送通知时间比专注时间设置的稍长一点
    );
  }

  Future<void> _enableTorch() async {
    try {
      await TorchLight.enableTorch();
    } on Exception catch (_) {
      debugPrint('Could not enable torch');
    }
  }

  Future<void> _disableTorch() async {
    try {
      await TorchLight.disableTorch();
    } on Exception catch (_) {
      debugPrint('Could not disable torch');
    }
  }

  @override
  Future<void> onResumed() async {
    super.onResumed();
    await ScreenBrightness.setScreenBrightness(screenBrightness);
    isInBackGround = false;
    if (!animateTimerFinish.value) {
      return;
    }
    _initSensor();
    _service
      ..invoke('stopFocusPageSendMsgTimer')
      ..invoke('stopFocusPageBackgroundTimer');
    await NotificationService().cancelAllNotifications();
  }

  @override
  void onClose() {
    disposeAll();
    NotificationService().cancelAllNotifications();
    super.onClose();
  }

  void disposeAll() {
    _streamSubscription?.cancel();
    _sensorTimer?.cancel();
    _stopCountDownTimer();
    _service
      ..invoke('stopHideButtonTimer')
      ..invoke('stopFocusPageSendMsgTimer')
      ..invoke('stopFocusPageBackgroundTimer');
    _longPressTimer?.cancel();
    animateTimer?.cancel();
    interruptTimer?.cancel();
  }
}
