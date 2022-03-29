import 'package:dio/dio.dart';

/// dio 配置项
class HttpConfig {
  final String? baseUrl;
  final String? proxy;
  final String? cookiesPath;
  final List<Interceptor>? interceptors;
  final int connectTimeout;
  final int sendTimeout;
  final int receiveTimeout;

  HttpConfig({
    final this.baseUrl,
    final this.proxy,
    final this.cookiesPath,
    final this.interceptors,
    final this.connectTimeout = Duration.millisecondsPerMinute,
    final this.sendTimeout = Duration.millisecondsPerMinute,
    final this.receiveTimeout = Duration.millisecondsPerMinute,
  });
}
