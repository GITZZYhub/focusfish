import 'dart:async';
import 'dart:convert';

import 'package:common/constants/argument_keys.dart';
import 'package:common/controller/base_controller.dart';
import 'package:common/utils/time_util.dart';
import 'package:flutter/material.dart';
import 'package:getx/getx.dart';
import 'package:pausable_timer/pausable_timer.dart';
import 'package:sensor_plugin/sensor_plugin.dart';
import 'package:vibrate_plugin/messages.dart';
import 'package:vibrate_plugin/vibrate_plugin.dart';

import '../../../../../routes/app_pages.dart';
import '../../focus.dart';

enum Status {
  running,
  paused,
}

class FocusController extends BaseController {
  FocusController({required final this.focusRepository});

  final IFocusRepository focusRepository;

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
  final currentStatus = Status.running.obs;

  //倒计时器
  late final PausableTimer _timer;

  //倒计时总时间
  final staticTime = 1 * 60;

  //倒计时剩余时间
  final countDown = 0.obs;

  //UI显示的时间
  final time = ''.obs;

  //倒计时暂停
  void pause() {
    currentStatus.value = Status.paused;
    _timer.pause();
  }

  //倒计时重新开始
  void resume() {
    currentStatus.value = Status.running;
    _timer.start();
    _initSensor();
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
          VibratePlugin.feedback(FeedbackType.error);
          _sensorTimer.cancel();
          _streamSubscription.cancel();
          pause();
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
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _timer.cancel();
    _streamSubscription.cancel();
    _sensorTimer.cancel();
    super.onClose();
  }
}
