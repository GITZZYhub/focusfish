import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';

/// 倒计时的后台服务
Future<void> initializeBackgroundService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will executed when app is in foreground
      // or background in separated isolate
      onStart: onStartService,

      // auto start service
      autoStart: true,
      isForegroundMode: false,
    ),
    iosConfiguration: IosConfiguration(
      // auto start service
      autoStart: true,

      // this will executed when app is in foreground in separated isolate
      onForeground: onStartService,

      // you have to enable background fetch capability on xcode project
      onBackground: onIosBackground,
    ),
  );
  await service.startService();
}

// to ensure this executed
// run app from xcode, then from xcode menu, select Simulate Background Fetch
bool onIosBackground(final ServiceInstance service) {
  WidgetsFlutterBinding.ensureInitialized();
  debugPrint('FLUTTER BACKGROUND FETCH');

  return true;
}

void onStartService(final ServiceInstance service) {
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((final event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((final event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((final event) {
    service.stopSelf();
  });
  focusCountDownTimerInit(service);
  hideButtonTimerInit(service);
  focusPageBackgroundTimerInit(service);
  focusPageSendMsgTimerInit(service);
  resultPageTimerInit(service);
}

///专注页面倒计时
Timer? focusCountDownTimer;

void focusCountDownTimerInit(final ServiceInstance service) {
  service.on('startFocusCountDownTimer').listen((final event) {
    focusCountDownTimer =
        Timer.periodic(const Duration(seconds: 1), (final timer) async {
      if (focusCountDownTimer == null) {
        timer.cancel();
        return;
      }
      service.invoke(
        'focusCountDown',
        {
          'tick': timer.tick,
        },
      );
    });
  });

  service.on('stopFocusCountDownTimer').listen((final event) {
    focusCountDownTimer?.cancel();
    focusCountDownTimer = null;
  });
}

/// 隐藏专注页面长按按钮计时器
Timer? hideButtonTimer;

void hideButtonTimerInit(final ServiceInstance service) {
  service.on('startHideButtonTimer').listen((final event) {
    hideButtonTimer =
        Timer.periodic(const Duration(milliseconds: 1000), (final timer) async {
      if (hideButtonTimer == null) {
        timer.cancel();
        return;
      }
      service.invoke(
        'hideButton',
        {
          'tick': timer.tick,
        },
      );
    });
  });

  service.on('stopHideButtonTimer').listen((final event) {
    hideButtonTimer?.cancel();
    hideButtonTimer = null;
  });
}

/// 专注页面进入后台倒计时
/// 进入后台5秒后发送通知
Timer? focusPageBackgroundTimer;

void focusPageBackgroundTimerInit(final ServiceInstance service) {
  service.on('startFocusPageBackgroundTimer').listen((final event) {
    focusPageBackgroundTimer =
        Timer.periodic(const Duration(seconds: 1), (final timer) async {
      if (focusPageBackgroundTimer == null) {
        timer.cancel();
        return;
      }
      service.invoke(
        'focusPageBackground',
        {
          'tick': timer.tick,
        },
      );
    });
  });

  service.on('stopFocusPageBackgroundTimer').listen((final event) {
    focusPageBackgroundTimer?.cancel();
    focusPageBackgroundTimer = null;
  });
}

/// 专注页面进入后台发送通知等待倒计时
/// 消息通知5s后，没回到专注鱼，退出专注-退回到APP主页
Timer? focusPageSendMsgTimer;

void focusPageSendMsgTimerInit(final ServiceInstance service) {
  service.on('startFocusPageSendMsgTimer').listen((final event) {
    focusPageSendMsgTimer =
        Timer.periodic(const Duration(seconds: 1), (final timer) async {
      if (focusPageSendMsgTimer == null) {
        timer.cancel();
        return;
      }
      service.invoke(
        'focusPageSendMsg',
        {
          'tick': timer.tick,
        },
      );
    });
  });

  service.on('stopFocusPageSendMsgTimer').listen((final event) {
    focusPageSendMsgTimer?.cancel();
    focusPageSendMsgTimer = null;
  });
}

/// 音频选择页面倒计时
Timer? resultPageTimer;

void resultPageTimerInit(final ServiceInstance service) {
  service.on('startResultPageTimer').listen((final event) {
    resultPageTimer =
        Timer.periodic(const Duration(seconds: 1), (final timer) async {
          if (resultPageTimer == null) {
            timer.cancel();
            return;
          }
          service.invoke(
            'resultPage',
            {
              'tick': timer.tick,
            },
          );
        });
  });

  service.on('stopResultPageTimer').listen((final event) {
    resultPageTimer?.cancel();
    resultPageTimer = null;
  });
}
