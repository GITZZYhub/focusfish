import 'dart:async';
import 'dart:convert';

import 'package:common/constants/argument_keys.dart';
import 'package:common/controller/base_controller.dart';
import 'package:common/utils/time_util.dart';
import 'package:getx/getx.dart';
import 'package:local_notification/local_notification.dart';
import 'package:pausable_timer/pausable_timer.dart';
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

  double screenBrightness = 0.1;

  // 获取传感器的值
  late StreamSubscription<dynamic> _streamSubscription;

  // 记录手机姿态角度的计时器
  late Timer _sensorTimer;

  // 当前手机姿态角度，手机平放为-90
  double _angleX = 0;

  // 记录手机姿态角度
  double _angleXPre = 0;

  // 每隔一定时间记录传感器的值
  final sensorTime = 800;

  //当前的计时状态
  final currentStatus = Status.hide_button.obs;

  //倒计时器
  late final PausableTimer _timer;

  //倒计时总时间
  final staticTime = 25 * 60;

  //倒计时剩余时间
  final countDown = 0.obs;

  //UI显示的时间
  final time = ''.obs;

  // 隐藏长按按钮计时器
  Timer? _hideButtonTimer;

  //中断时间
  static const interruptTime = 5;

  // app进入后台的计时器
  Timer? _backgroundTimer;

  // 消息通知5s后，没回到专注鱼，退出专注-退回到APP主页
  Timer? _sentMsgTimer;

  bool? isInBackGround;

  final circleProgressValue = 0.0.obs;

  //长按倒计时
  Timer? _longPressTimer;

  //倒计时暂停
  void pause() {
    _timer.pause();
  }

  //倒计时重新开始
  void resume() {
    _timer.start();
    _initSensor();
  }

  //显示长按按钮
  Future<void> showButton({required final bool isPress}) async {
    currentStatus.value = Status.show_button;
    if (_hideButtonTimer != null) {
      _hideButtonTimer?.cancel();
    }
    _hideButtonTimer = Timer(
      const Duration(milliseconds: 5000),
      hideButton,
    );
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
  void onInit() {
    super.onInit();
    _initTimer();
    _initSensor();
  }

  void _initTimer() {
    countDown.value = staticTime;
    time.value =
        TimeUtil.convertTime(countDown.value ~/ 60, countDown.value % 60);
    _timer = PausableTimer(const Duration(seconds: 1), () {
      countDown.value--;
      time.value =
          TimeUtil.convertTime(countDown.value ~/ 60, countDown.value % 60);
      if (countDown.value > 0) {
        // we know the callback won't be called before the constructor ends, so
        // it is safe to use !
        _timer
          ..reset()
          ..start();
      } else if (countDown.value == 0) {
        if (isInBackGround ?? false) {
          sendFinishFocusMsg();
        }
        gotoNextPage();
      }
    })
      ..start();
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
          // pause();
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
      _backgroundTimer =
          Timer.periodic(const Duration(seconds: 1), (final timer) async {
        final brightness = await ScreenBrightness.currentBrightness;
        if (timer.tick <= interruptTime && brightness == 0.0) {
          //app进入后台并且在5s内锁屏，倒计时继续
          timer.cancel();
        } else if (timer.tick > interruptTime && brightness != 0.0) {
          timer.cancel();
          //app进入后台并且亮屏超过5s，立即发消息通知
          await sendBackToFocusMsg();
          // 消息通知5s后，没回到专注鱼，退出专注-退回到APP主页
          _sentMsgTimer = Timer(
            const Duration(seconds: interruptTime),
            goBack,
          );
        }
      });
    }
  }

  Future<void> sendBackToFocusMsg() async {
    await NotificationService().showNotification(
      NotificationPayload.backToFocus.index,
      '专注鱼',
      '立即点击此处回到专注鱼，以免中断专注。',
      NotificationPayload.backToFocus.toString(),
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
    _sentMsgTimer?.cancel();
    _backgroundTimer?.cancel();
  }

  @override
  void onClose() {
    disposeAll();
    super.onClose();
  }

  void disposeAll() {
    _timer.cancel();
    _streamSubscription.cancel();
    _sensorTimer.cancel();
    _hideButtonTimer?.cancel();
    _sentMsgTimer?.cancel();
    _backgroundTimer?.cancel();
    _longPressTimer?.cancel();
    NotificationService()
        .cancelNotification(NotificationPayload.backToFocus.index);
  }
}
