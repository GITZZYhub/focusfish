import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:my_logger/my_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../multipart_file_extended.dart';
import 'config_url_key.dart';
import 'retry_options.dart';

/// An interceptor that will try to send failed request again
///
/// final response = await dio.get("http://www.flutter.dev", options: Options(
///     extra: RetryOptions.noRetry().toExtra(),
/// ));
/// final response = await dio.get("http://www.flutter.dev", options: Options(
///   extra: RetryOptions(
///     retryInterval: const Duration(seconds: 10),
///   ).toExtra(),
/// ));
///
class RetryInterceptor extends Interceptor {
  final Dio dio;
  final RetryOptions options;

  RetryInterceptor({required final this.dio, final RetryOptions? options})
      : options = options ?? const RetryOptions();

  @override
  Future<void> onError(
    final DioError err,
    final ErrorInterceptorHandler handler,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    var extra = RetryOptions.fromExtra(err.requestOptions) ?? options;

    final shouldRetry = extra.retries! > 0 && await extra.retryEvaluator(err);
    final configUrlKey = extra.configUrlKey;
    if (shouldRetry) {
      if (extra.retryInterval!.inMilliseconds > 0) {
        await Future<dynamic>.delayed(extra.retryInterval!);
      }

      // Update options to decrease retry count before new try
      extra = extra.copyWith(retries: extra.retries! - 1);
      err.requestOptions.extra = err.requestOptions.extra
        ..addAll(extra.toExtra());

      logHttpError(
        error: '${err.requestOptions.path} - 正在重试...',
        needStack: false,
      );
      await _dioRequest(err, err.requestOptions.path).then((final response) {
        logHttpInfo(
          info: '${err.requestOptions.path} - 重试成功...',
          needStack: false,
        );
        handler.resolve(response);
      }).catchError((final error) {
        logHttpError(
          error: '${err.requestOptions.path} - 重试失败...',
          needStack: false,
        );
        handler.next(error);
      }).whenComplete(() {});
    } else if (configUrlKey != null) {
      // 如果有可切换的url则进行切换
      final configUrlStr = prefs.getString(configUrlKey);
      final requestedUrlStr = prefs.getString(requestedUrlKey);
      if (configUrlStr != null &&
          configUrlStr.isNotEmpty &&
          requestedUrlStr != null) {
        // 重新设置重试次数
        extra = extra.copyWith(retries: retryCount);
        err.requestOptions.extra = err.requestOptions.extra
          ..addAll(extra.toExtra());
        final List<dynamic> configUrls = jsonDecode(configUrlStr);
        final List<dynamic> requestedUrls =
            jsonDecode(requestedUrlStr); // 已经请求过的url
        if (requestedUrls.isEmpty) {
          requestedUrls.add(configUrls[0]);
        }
        if (!const ListEquality<dynamic>().equals(configUrls, requestedUrls)) {
          final tmpUrl = configUrls[requestedUrls.length];
          requestedUrls.add(tmpUrl);
          logHttpError(
            error: '[$tmpUrl] trying another url',
            needStack: false,
          );
          await prefs.setString(requestedUrlKey, jsonEncode(requestedUrls));
          await _dioRequest(err, tmpUrl).then((final response) {
            logHttpInfo(
              info: '[$tmpUrl] trying another url sucess',
              needStack: false,
            );
            handler.resolve(response);
          }).catchError((final error) {
            logHttpError(
              error: '[$tmpUrl] trying another url failed',
              needStack: false,
            );
            handler.next(error);
          }).whenComplete(() {});
        }
      } else {
        // 所有url都失败后清除缓存
        await prefs.remove(requestedUrlKey);
      }
    }
    return super.onError(err, handler);
  }

  Future<Response<dynamic>> _dioRequest(
    final DioError err,
    final String url,
  ) async {
    if (err.requestOptions.data is FormData) {
      final formData = FormData();
      formData.fields.addAll(err.requestOptions.data.fields);

      for (final mapFile in err.requestOptions.data.files) {
        formData.files.add(
          MapEntry(
            mapFile.key,
            MultipartFileExtended.fromFileSync(
              mapFile.value.filePath,
            ),
          ),
        );
      }
      err.requestOptions.data = formData;
    }
    return dio.request(
      url,
      cancelToken: err.requestOptions.cancelToken,
      data: err.requestOptions.data,
      onReceiveProgress: err.requestOptions.onReceiveProgress,
      onSendProgress: err.requestOptions.onSendProgress,
      queryParameters: err.requestOptions.queryParameters,
      options: Options(
        contentType: err.requestOptions.contentType,
        extra: err.requestOptions.extra,
        followRedirects: err.requestOptions.followRedirects,
        headers: err.requestOptions.headers,
        listFormat: err.requestOptions.listFormat,
        maxRedirects: err.requestOptions.maxRedirects,
        method: err.requestOptions.method,
        receiveDataWhenStatusError:
            err.requestOptions.receiveDataWhenStatusError,
        receiveTimeout: err.requestOptions.receiveTimeout,
        requestEncoder: err.requestOptions.requestEncoder,
        responseDecoder: err.requestOptions.responseDecoder,
        responseType: err.requestOptions.responseType,
        sendTimeout: err.requestOptions.sendTimeout,
        validateStatus: err.requestOptions.validateStatus,
      ),
    );
  }
}
