import 'package:flutter/material.dart';
import '../../resources.dart';

class ColorSchemeLight {
  ColorSchemeLight._();
  static final ColorScheme colorScheme = ColorScheme(
    primary: ColorRes.primaryLight,
    primaryVariant: ColorRes.appMaterialColorLight.shade700,
    // 小部件的前景色(旋钮、文本、覆盖边缘效果等)。
    secondary: ColorRes.appMaterialColorLight.shade500,
    secondaryVariant: ColorRes.appMaterialColorLight.shade700,
    surface: ColorRes.surfaceLight,
    background: ColorRes.appMaterialColorLight.shade200,
    error: ColorRes.errorColor,
    onPrimary: ColorRes.onPrimaryLight,
    onSecondary: ColorRes.onSecondaryLight,
    onSurface: ColorRes.onSurfaceLight,
    onBackground: ColorRes.onBackgroundLight,
    onError: ColorRes.onErrorLight,
    brightness: Brightness.light,
  );
}
