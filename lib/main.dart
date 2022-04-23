import 'dart:async';

import 'package:common/audio_services/service_locator.dart';
import 'package:common/background_services/services.dart';
import 'package:common/env/app_env.dart';
import 'package:common/utils/sp_utils/sp_utils.dart';
import 'package:dio_http/dio_http.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:getx/getx.dart';
import 'package:local_notification/local_notification.dart';
import 'package:my_logger/my_logger.dart';
import 'package:my_sentry/sentry.dart';
import 'package:native_string/native_string.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 强制竖屏
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  await NotificationService().init();
  await _initSharedPreferences();
  _initHttp();
  await setupServiceLocator();
  await initializeBackgroundService();
  await SentryFlutter.init(
    (final options) => options
      ..dsn = NativeString.getString(SENTRY_DSN)
      ..debug = kDebugMode // 是否打印sentry日志
      ..environment = 'crash'
      ..diagnosticLevel = SentryLevel.info
      ..maxBreadcrumbs = 1000
      ..attachStacktrace = true
      ..sendDefaultPii = true,
    appRunner: () => runApp(App()),
  );
}

///本地持久化
Future<void> _initSharedPreferences() async {
  // must wait for SPUtil to finish initialization
  final success = await SPUtils.getInstance().initialization();
  logCommonInfo(info: 'SharedPreference init $success', needStack: false);
}

///初始化http请求配置
void _initHttp() {
  final dioConfig = HttpConfig(
    baseUrl: NativeString.getString(
      getCurrentAppEnv() == AppEnv.dev
          ? SERVER_BASE_URL_DEV
          : SERVER_BASE_URL_PROD,
    ),
  );
  final client = HttpClient(dioConfig: dioConfig);
  // 添加重试机制
  client.appDio.interceptors.add(
    RetryInterceptor(
      dio: client.appDio,
      options: const RetryOptions(),
    ),
  );
  // 添加响应拦截
  client.appDio.interceptors.add(ResponseInterceptor());
  Get.put<HttpClient>(client);
}
