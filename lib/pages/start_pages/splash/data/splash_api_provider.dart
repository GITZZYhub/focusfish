import 'package:common/utils/init_util.dart';
import 'package:dio_http/dio_http.dart';

abstract class ISplashProvider {
  Future<HttpResponse> initData(
    final String requestUrl,
    final Map<String, dynamic> queryParameters,
  );

  ///取消初始化app数据的请求
  void cancelRequest();
}

CancelToken? _cancelToken;

class SplashProvider implements ISplashProvider {
  @override
  Future<HttpResponse> initData(
    final String requestUrl,
    final Map<String, dynamic> queryParameters,
  ) async =>
      httpClient.post(
        requestUrl,
        baseUrl: '',
        configUrlKey: '',
        data: queryParameters,
        cancelToken: _cancelToken,
      );

  @override
  void cancelRequest() {
    if (_cancelToken != null && !_cancelToken!.isCancelled) {
      _cancelToken?.cancel();
      _cancelToken = null;
    }
  }
}
