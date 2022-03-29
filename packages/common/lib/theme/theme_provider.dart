import 'package:common/utils/sp_utils/sp_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getx/getx.dart';
import 'package:resources/resources.dart';

enum ThemeIndex {
  system,
  light,
  dark,
}

///获取当前app设置的主题色调
ThemeMode getAppThemeMode() {
  if (SPUtils.getInstance().getThemeIndex() ==
      ThemeIndex.system.index.toString()) {
    return ThemeMode.system;
  } else if (SPUtils.getInstance().getThemeIndex() ==
      ThemeIndex.light.index.toString()) {
    return ThemeMode.light;
  } else {
    return ThemeMode.dark;
  }
}

class ThemeProvider {
  ThemeProvider._();
  static final themeBackgroundColor = CupertinoColors.white.obs;
  static final reverseThemeBackgroundColor = ColorRes.iosTileDarkColor.obs;
  static final phoneAreaCodeTextColor = ColorRes.textColorLight3.obs;
  static final phoneAreaCodeTtitleBackgroundColor =
      ColorRes.backgroundLight.obs;
  static final dividerColor = ColorRes.dividerColorLight.obs;
  static final indexBarBackgroundColor = ColorRes.iosTileDarkColor.obs;
  static final focusBorderColor = ColorRes.primaryLight.obs;
  static final borderSideColor = ColorRes.secondaryVariantLight.obs;
  static final indicatorItemColor = ColorRes.appMaterialColorDark.shade200.obs;
  static final indicatorActiveItemColor = ColorRes.secondaryDark.obs;
  static final avatarBorderColor = ColorRes.primaryLight.obs;

  ///needReverse参数在didChangePlatformBrightness()中使用，
  ///如果没有此参数，会出现系统切换到暗色（浅色）模式时程序错误的将自定义颜色
  ///设置成了浅色（暗色）模式下的值。
  ///猜测原因可能是系统切换时MediaQuery.platformBrightnessOf(context)函数结果
  ///未及时更新的缘故。
  static void setExtraColor({
    required final BuildContext context,
    final bool needReverse = false,
  }) {
    final themeMode = getAppThemeMode();
    if (themeMode == ThemeMode.system) {
      _setExtraColorAuto(context, reverse: needReverse);
    } else if (themeMode == ThemeMode.dark) {
      _setExtraColorDarkMode();
    } else {
      _setExtraColorLightMode();
    }
  }

  static void _setExtraColorLightMode() {
    themeBackgroundColor.value = CupertinoColors.white;
    reverseThemeBackgroundColor.value = ColorRes.iosTileDarkColor;
    phoneAreaCodeTextColor.value = ColorRes.textColorLight3;
    phoneAreaCodeTtitleBackgroundColor.value = ColorRes.backgroundLight;
    dividerColor.value = ColorRes.dividerColorLight;
    indexBarBackgroundColor.value = ColorRes.iosTileDarkColor;
    focusBorderColor.value = ColorRes.primaryLight;
    borderSideColor.value = ColorRes.secondaryVariantLight;
    indicatorItemColor.value = ColorRes.appMaterialColorLight.shade200;
    indicatorActiveItemColor.value = ColorRes.secondaryLight;
    avatarBorderColor.value = ColorRes.primaryLight;
  }

  static void _setExtraColorDarkMode() {
    themeBackgroundColor.value = ColorRes.iosTileDarkColor;
    reverseThemeBackgroundColor.value = CupertinoColors.white;
    phoneAreaCodeTextColor.value = CupertinoColors.white;
    phoneAreaCodeTtitleBackgroundColor.value = ColorRes.iosPressedTileColorDark;
    dividerColor.value = ColorRes.dividerColorDark;
    indexBarBackgroundColor.value = ColorRes.secondaryDark;
    focusBorderColor.value = ColorRes.primaryDark;
    borderSideColor.value = ColorRes.onBackgroundDark;
    indicatorItemColor.value = ColorRes.appMaterialColorDark.shade200;
    indicatorActiveItemColor.value = ColorRes.secondaryDark;
    avatarBorderColor.value = ColorRes.primaryDark;
  }

  static void _setExtraColorAuto(
    final BuildContext context, {
    final bool reverse = false,
  }) {
    var reference = Brightness.dark;
    if (reverse) {
      reference = Brightness.light;
    }
    if (MediaQuery.platformBrightnessOf(context) == reference) {
      _setExtraColorDarkMode();
    } else {
      _setExtraColorLightMode();
    }
  }
}
