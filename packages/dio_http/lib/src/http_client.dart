import 'dart:convert';

import 'package:common/utils/sp_utils/sp_utils.dart';
import 'package:my_logger/my_logger.dart';

import '../dio_http.dart';
import 'app_dio.dart';
import 'http_parse.dart';

class HttpClient {
  late final AppDio _dio;

  HttpClient({final BaseOptions? options, final HttpConfig? dioConfig})
      : _dio = AppDio(options: options, dioConfig: dioConfig);

  AppDio get appDio => _dio;

  Future<HttpResponse> get(
    final String uri, {
    final Map<String, dynamic>? queryParameters,
    required final String? baseUrl,
    required final String? configUrlKey,
    final Options? options,
    final CancelToken? cancelToken,
    final ProgressCallback? onReceiveProgress,
    final HttpTransformer? httpTransformer,
  }) async {
    try {
      final response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: _beforeRequestConfig(options, baseUrl, configUrlKey),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return handleResponse(response, httpTransformer: httpTransformer);
    } on Exception catch (e) {
      return handleException(e);
    }
  }

  Future<HttpResponse> post(
    final String uri, {
    // ignore: type_annotate_public_apis
    final data,
    final Map<String, dynamic>? queryParameters,
    required final String? baseUrl,
    required final String? configUrlKey,
    final Options? options,
    final CancelToken? cancelToken,
    final ProgressCallback? onSendProgress,
    final ProgressCallback? onReceiveProgress,
    final HttpTransformer? httpTransformer,
  }) async {
    try {
      final response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: _beforeRequestConfig(options, baseUrl, configUrlKey),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      _reOrderConfigUrls(configUrlKey);
      return handleResponse(response, httpTransformer: httpTransformer);
    } on Exception catch (e) {
      return handleException(e);
    }
  }

  /// 在请求之前的配置
  Options? _beforeRequestConfig(
    final Options? options,
    final String? baseUrl,
    final String? configUrlKey,
  ) {
    if (baseUrl != null && baseUrl.isNotEmpty) {
      _dio.options.baseUrl = baseUrl;
    }
    // configUrlKey不为空说明有可切换的url
    if (configUrlKey != null && configUrlKey.isNotEmpty) {
      final newOptions = options == null
          ? Options(
              extra: RetryOptions(
                configUrlKey: configUrlKey,
              ).toExtra(),
            )
          : (options.extra == null
              ? options.copyWith(
                  extra: RetryOptions(
                    configUrlKey: configUrlKey,
                  ).toExtra(),
                )
              : options.copyWith(
                  extra: options.extra!
                    ..addAll(
                      RetryOptions(
                        configUrlKey: configUrlKey,
                      ).toExtra(),
                    ),
                ));
      // 在这里初始化一下已请求过的URL，在retry拦截器里有用到
      SPUtils.getInstance()
          .getSharedPreferences()
          ?.setString(requestedUrlKey, jsonEncode([]));

      return newOptions;
    }
    return options;
  }

  /// 请求成功后，将本地存储的configUrls的顺序做调整
  void _reOrderConfigUrls(final String? configUrlKey) {
    final prefs = SPUtils.getInstance().getSharedPreferences();
    final requestedUrlStr = prefs?.getString(requestedUrlKey);
    if (requestedUrlStr == null) {
      // 所有url都切换过并且均没有成功，则不需要重新配置
      return;
    }
    final requestedUrls = jsonDecode(requestedUrlStr);
    if (requestedUrls.length == 0) {
      // 没有切换过其他url，不需要重新配置，将之前的缓存清空
      prefs?.remove(requestedUrlKey);
      return;
    }
    if (configUrlKey == null || configUrlKey.isEmpty) {
      // 不需要重新配置
      return;
    }
    // 剩下的情况就是已经发生过url的切换，需要重新配置
    logHttpInfo(info: '_reOrderConfigUrls重新配置url', needStack: false);
    final configUrlStr = prefs?.getString(configUrlKey);
    final configUrls = jsonDecode(configUrlStr!);

    // requestedUrls最后一个元素必定是请求成功的url，将configUrls与之对应的index之前所有元素移至列表尾
    final index = configUrls.indexOf(requestedUrls.last);
    final newConfigUrls = <String>[];
    configUrls.asMap().forEach((final idx, final url) {
      if (idx >= index) {
        newConfigUrls.add(url);
      }
    });
    configUrls.asMap().forEach((final idx, final url) {
      if (idx < index) {
        newConfigUrls.add(url);
      }
    });
    prefs?.setString(configUrlKey, jsonEncode(newConfigUrls));
  }

  Future<HttpResponse> patch(
    final String uri, {
    final FormData? data,
    final Map<String, dynamic>? queryParameters,
    final Options? options,
    final CancelToken? cancelToken,
    final ProgressCallback? onSendProgress,
    final ProgressCallback? onReceiveProgress,
    final HttpTransformer? httpTransformer,
  }) async {
    try {
      final response = await _dio.patch(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return handleResponse(response, httpTransformer: httpTransformer);
    } on Exception catch (e) {
      return handleException(e);
    }
  }

  Future<HttpResponse> delete(
    final String uri, {
    final FormData? data,
    final Map<String, dynamic>? queryParameters,
    final Options? options,
    final CancelToken? cancelToken,
    final HttpTransformer? httpTransformer,
  }) async {
    try {
      final response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return handleResponse(response, httpTransformer: httpTransformer);
    } on Exception catch (e) {
      return handleException(e);
    }
  }

  Future<HttpResponse> put(
    final String uri, {
    final FormData? data,
    final Map<String, dynamic>? queryParameters,
    final Options? options,
    final CancelToken? cancelToken,
    final HttpTransformer? httpTransformer,
  }) async {
    try {
      final response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return handleResponse(response, httpTransformer: httpTransformer);
    } on Exception catch (e) {
      return handleException(e);
    }
  }

  Future<Response<dynamic>> download(
    final String urlPath,
    final String savePath, {
    final ProgressCallback? onReceiveProgress,
    final Map<String, dynamic>? queryParameters,
    final CancelToken? cancelToken,
    final bool deleteOnError = true,
    final String lengthHeader = Headers.contentLengthHeader,
    final FormData? data,
    final Options? options,
    final HttpTransformer? httpTransformer,
  }) async {
    try {
      final response = await _dio.download(
        urlPath,
        savePath,
        onReceiveProgress: onReceiveProgress,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        deleteOnError: deleteOnError,
        lengthHeader: lengthHeader,
        data: data,
        options: options,
      );
      return response;
    } on DioError catch (_) {
      rethrow;
    }
  }
}
