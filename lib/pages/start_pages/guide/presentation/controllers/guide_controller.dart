import 'package:common/controller/base_controller.dart';
import 'package:common/utils/sp_utils/sp_utils.dart';
import 'package:flutter/material.dart';
import 'package:getx/getx.dart';
import 'package:localization/localization.dart';
import 'package:resources/resources.dart';

import '../../../../../routes/routes.dart';

class GuideController extends BaseController {
  List<String> getPageSrcList(final BuildContext context) {
    if (isCN(context)) {
      return [R.jpg.guide1Cn, R.jpg.guide2Cn, R.jpg.guide3Cn];
    } else if (isTR(context)) {
      return [R.jpg.guide1Tr, R.jpg.guide2Tr, R.jpg.guide3Tr];
    } else {
      return [R.jpg.guide1En, R.jpg.guide2En, R.jpg.guide3En];
    }
  }

  ///跳转到启动页
  void enterSplash() {
    SPUtils.getInstance().setFirstEnterState(isFirstEnter: false);
    Get.offNamed(Routes.splash);
  }

  @override
  void onClose() {
    super.onClose();
  }
}
