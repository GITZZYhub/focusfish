import 'package:common/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:getx/getx.dart';

class BaseController extends SuperController<dynamic> {
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance!.addPostFrameCallback((final timeStamp) {
      ThemeProvider.setExtraColor(context: Get.context!);
    });
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    ThemeProvider.setExtraColor(context: Get.context!, needReverse: true);
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {
    // 由于应用在退到后台也会调用didChangePlatformBrightness方法，导致应用主题切换错误，所以
    // 在回到应用时调用主题设置即可恢复正常。
    ThemeProvider.setExtraColor(context: Get.context!);
  }
}
