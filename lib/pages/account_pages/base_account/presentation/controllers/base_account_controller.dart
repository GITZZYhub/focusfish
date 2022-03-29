import 'package:common/controller/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:getx/getx.dart';
import 'package:moor_db/moor_db.dart';
import 'package:my_logger/my_logger.dart';

import '../../base_account.dart';
import '../../data/entity/login_data.dart';

class BaseAccountController extends BaseController {
  BaseAccountController({
    required final this.baseRepository,
  });

  final BaseAccountRepository baseRepository;

  LoginUserInfo? loginUserInfo;
  final userName = ''.obs;
  final avatarPath = ''.obs;


  ///保存登录信息到数据库
  Future<bool> saveLoginUserInfo({
    required final BuildContext context,
    required final LoginData loginData,
  }) async {
    try {
      await baseRepository.saveLoginInfoToDB(loginData);
      return true;
    } on Exception catch (e) {
      logHttpError(error: '$e', needStack: true);
    }
    return false;
  }

  ///更新数据库中登录数据
  Future<bool> updateLoginUserInfo(final LoginUserInfo? userInfo) async {
    if (loginUserInfo == null) {
      return false;
    } else {
      final updateState = await baseRepository.updateLoginUserInfo(userInfo!);
      if (updateState) {
        loginUserInfo = userInfo;
        update();
        return true;
      } else {
        return false;
      }
    }
  }

  ///退出账号时，删除对应的数据库数据
  Future<bool> deleteUser(final String userId) async {
    try {
      await baseRepository.deleteUser(userId);
      return true;
    } on Exception catch (e) {
      logHttpError(error: '$e', needStack: true);
    }
    return false;
  }
}
