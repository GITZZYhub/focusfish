import '../splash.dart';
import 'entity/init_data.dart';

abstract class ISplashRepository {
  Future<InitData> requestToken(
    final String requestUrl,
    final Map<String, dynamic> queryParameters,
  );

  void cancelRequest();
}

class SplashRepository implements ISplashRepository {
  SplashRepository({required final this.provider});

  final SplashProvider provider;

  @override
  Future<InitData> requestToken(
    final String requestUri,
    final Map<String, dynamic> queryParameters,
  ) async {
    try {
      final response = await provider.requestToken(
        requestUri,
        queryParameters,
      );
      if (response.ok) {
        return InitData.fromJson(response.data);
      } else {
        return Future.error(response.error!);
      }
    } on Exception catch (e) {
      return Future.error(e);
    }
  }

  ///取消获取广告的请求
  @override
  void cancelRequest() {
    provider.cancelRequest();
  }
}
