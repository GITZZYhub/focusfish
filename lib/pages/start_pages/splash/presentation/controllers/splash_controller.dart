import 'dart:async';
import 'dart:io';

import 'package:common/constants/sever_keys.dart';
import 'package:common/controller/base_controller.dart';
import 'package:common/utils/sp_utils/sp_utils.dart';
import 'package:common/utils/time_util.dart';
import 'package:common/widgets/dialog.dart';
import 'package:getx/getx.dart';
import 'package:localization/localization.dart';
import 'package:my_logger/my_logger.dart';

import '../../../../../routes/routes.dart';
import '../../splash.dart';

class SplashController extends BaseController {
  SplashController({required final this.repository});

  ///当前页面最小等待时间
  final _waitTime = 2000;
  final SplashRepository repository;

  ///页面刚开始渲染时间
  int _startTime = 0;

  @override
  void onInit() {
    super.onInit();
    _startTime = TimeUtil.currentTimeMillis();
    _initAppData();
  }

  ///获取app的初始化数据
  Future<void> _initAppData() async {
    _stayAndFinish();
    // final queryParameters = <String, dynamic>{};
    // queryParameters[ServerKeys.client] = 'APP';
    // queryParameters[ServerKeys.grantType] = 'open_wechat';
    // queryParameters[ServerKeys.appid] = '';
    // queryParameters[ServerKeys.code] = 0;
    // await repository
    //     .requestToken('/oauth/token', queryParameters)
    //     .then((final value) {
    //   _stayAndFinish();
    // }).catchError((final error) {
    //   logHttpError(error: '${error.message}', needStack: true);
    //   _showTipsDialog();
    // });
  }

  @override
  void onClose() {
    super.onClose();
    repository.cancelRequest();
  }

  ///当获取APP的URL的配置失败时，弹出提示框
  Future<void> _showTipsDialog() async {
    if (!isClosed) {
      final result = await showCustomDialog(
        Get.context!,
        type: DialogType.error,
        title: AppLocalizations.of(Get.context!)!.tips,
        content: AppLocalizations.of(Get.context!)!.init_data_failed,
        doubleButton: false,
        cancellable: false,
        closeOverlays: true,
      );
      if (result != null && result) {
        //退出应用
        exit(0);
      }
    }
  }

  ///开始页面倒计时，保证至少在此页面停留一定时间
  void _stayAndFinish() {
    final currentMillis = TimeUtil.currentTimeMillis();
    final diffMillis = currentMillis - _startTime;
    if (diffMillis > _waitTime) {
      _enterNextPage();
    } else {
      final delayTime = _waitTime - diffMillis;
      Future.delayed(
        Duration(milliseconds: delayTime),
        _enterNextPage,
      );
    }
  }

  ///跳转到下一个页面
  void _enterNextPage() {
    SPUtils.getInstance().getIsLoggedIn()
        ? Get.offNamed<dynamic>(Routes.home)
        : Get.offNamed<dynamic>(Routes.login);
  }
}
