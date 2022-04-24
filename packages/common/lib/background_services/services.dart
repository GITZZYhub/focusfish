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
  focusPageBackgroundTimerInit(service);
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
