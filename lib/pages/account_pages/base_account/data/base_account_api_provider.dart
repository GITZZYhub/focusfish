import 'package:moor_db/moor_db.dart';
import 'package:my_logger/my_logger.dart';

import 'entity/login_data.dart';

abstract class IBaseAccountProvider {
  ///保存设备登录信息到数据库
  Future<bool> saveLoginInfoToDB(
    final LoginData loginData,
  );

  Future<bool> updateLoginUserInfo(final LoginUserInfo loginUserInfo);

  ///删除用户
  Future<bool> deleteUser(final String userId);
}

class BaseAccountProvider implements IBaseAccountProvider {
  @override
  Future<bool> saveLoginInfoToDB(
    final LoginData loginData,
  ) async {
    try {
      if(loginData.idUser == null) {
        throw Exception('user id is null');
      }
      await deleteUser(loginData.idUser!);

      final loginUserInfo = LoginUserInfo(
        birthday: loginData.birthday,
        gender: loginData.gender,
        email: loginData.email,
        name: loginData.nickname,
        userId: loginData.idUser,
        avatarPath: loginData.avatar,
      );

      await loginUserInfoDao.insertUser(loginUserInfo);
      return true;
    } on Exception catch (e) {
      logDatabaseError(error: '$e', needStack: true);
    }
    return false;
  }

  @override
  Future<bool> deleteUser(final String userId) async {
    try {
      await loginUserInfoDao.deleteUserByUserId(userId);
      return true;
    } on Exception catch (e) {
      logDatabaseError(error: '$e', needStack: true);
    }
    return false;
  }

  @override
  Future<bool> updateLoginUserInfo(final LoginUserInfo userInfo) async {
    try {
      await loginUserInfoDao.updateLoginUserInfo(userInfo);
      return true;
    } on Exception catch (e) {
      logDatabaseError(error: '$e', needStack: true);
    }
    return false;
  }
}
