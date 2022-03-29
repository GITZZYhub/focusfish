import 'package:common/utils/init_util.dart';
import 'package:common/utils/sp_utils/sp_keys.dart';
import 'package:dio_http/dio_http.dart';
import '../../base_account/data/base_account_api_provider.dart';

abstract class ILoginProvider {
  ///设备登录
  Future<HttpResponse> login(final Map<String, dynamic> queryParameters);

  ///取消登录的请求
  void cancelLoginRequest();
}

CancelToken? _loginToken = CancelToken();

class LoginProvider extends BaseAccountProvider implements ILoginProvider {
  @override
  Future<HttpResponse> login(final Map<String, dynamic> queryParameters) async {
    _loginToken = CancelToken();
    await Future.delayed(const Duration(seconds: 2));
    return HttpResponse.success({
      'birthday': '',
      'firstname': '',
      'gender': 0,
      'avatar': '',
      'lastname': '',
      'token': '',
      'idUser': '',
      'nickname': '',
      'email': '',
    });
    return httpClient.post(
      '',
      baseUrl: '',
      configUrlKey: '',
      data: queryParameters,
      cancelToken: _loginToken,
    );
  }

  @override
  void cancelLoginRequest() {
    if (_loginToken != null && !_loginToken!.isCancelled) {
      _loginToken?.cancel();
      _loginToken = null;
    }
  }
}
