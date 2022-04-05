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
    final String? baseUrl,
    final Options? options,
    final CancelToken? cancelToken,
    final ProgressCallback? onReceiveProgress,
    final HttpTransformer? httpTransformer,
  }) async {
    try {
      final response = await _dio.get(
        uri,
        queryParameters: queryParameters,
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
    final String? baseUrl,
    final Options? options,
    final CancelToken? cancelToken,
    final ProgressCallback? onSendProgress,
    final ProgressCallback? onReceiveProgress,
    final HttpTransformer? httpTransformer,
  }) async {
    try {
      if (baseUrl != null && baseUrl.isNotEmpty) {
        _dio.options.baseUrl = baseUrl;
      }
      final response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return handleResponse(response, httpTransformer: httpTransformer);
    } on Exception catch (e) {
      return handleException(e);
    }
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
