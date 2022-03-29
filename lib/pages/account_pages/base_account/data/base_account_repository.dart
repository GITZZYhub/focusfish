import 'package:moor_db/moor_db.dart';

import 'base_account_api_provider.dart';
import 'entity/login_data.dart';

abstract class IBaseAccountRepository {
  ///保存用户登录信息到数据库中
  Future<bool> saveLoginInfoToDB(final LoginData loginData);

  ///更新登录数据
  Future<bool> updateLoginUserInfo(final LoginUserInfo userInfo);

  ///删除用户
  Future<bool> deleteUser(final String userId);
}

class BaseAccountRepository implements IBaseAccountRepository {
  BaseAccountRepository({required final this.baseProvider});

  final BaseAccountProvider baseProvider;

  @override
  Future<bool> saveLoginInfoToDB(
    final LoginData loginData,
  ) async =>
      baseProvider.saveLoginInfoToDB(loginData);

  @override
  Future<bool> deleteUser(final String userId) async =>
      baseProvider.deleteUser(userId);

  @override
  Future<bool> updateLoginUserInfo(final LoginUserInfo userInfo) async =>
      baseProvider.updateLoginUserInfo(userInfo);
}
