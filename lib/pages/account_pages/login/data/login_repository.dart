import 'package:dio_http/dio_http.dart';
import '../../base_account/data/base_account_repository.dart';
import '../../base_account/data/entity/login_data.dart';

import '../login.dart';

abstract class ILoginRepository {
  ///设备登录
  Future<LoginData> login(final Map<String, dynamic> queryParameters);

  ///取消登录的请求
  void cancelLoginRequest();
}

class LoginRepository extends BaseAccountRepository
    implements ILoginRepository {
  LoginRepository({required final this.provider})
      : super(baseProvider: provider);
  final LoginProvider provider;

  ///取消登录的请求
  @override
  void cancelLoginRequest() {
    provider.cancelLoginRequest();
  }

  @override
  Future<LoginData> login(final Map<String, dynamic> queryParameters) async {
    try {
      final response = await provider.login(queryParameters);
      if (response.ok) {
        return LoginData.fromJson(response.data);
      } else {
        return Future.error(response.error!);
      }
    } on DioError catch (e) {
      return Future.error(e.error);
    }
  }
}
