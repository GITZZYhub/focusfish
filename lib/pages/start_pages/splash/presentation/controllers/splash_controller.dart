import 'dart:async';
import 'dart:io';

import 'package:common/controller/base_controller.dart';
import 'package:common/utils/time_util.dart';
import 'package:common/widgets/dialog.dart';
import 'package:getx/getx.dart';
import 'package:localization/localization.dart';

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
    _enterNextPage();
    // final queryParameters = {'': ''};
    // await repository
    //     .initData('requestUrl', queryParameters)
    //     .then((final value) {
    //   _enterNextPage();
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

  ///跳转到下一个页面
  void _enterNextPage() {
    final currentMillis = TimeUtil.currentTimeMillis();
    final diffMillis = currentMillis - _startTime;
    if (diffMillis > _waitTime) {
      _enterLoginPage();
    } else {
      final delayTime = _waitTime - diffMillis;
      Future.delayed(Duration(milliseconds: delayTime), _enterLoginPage);
    }
  }

  void _enterLoginPage() {
    Get.offNamed<dynamic>(Routes.login);
  }
}
