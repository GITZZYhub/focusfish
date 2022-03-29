import 'package:flutter/material.dart';
import '../../resources.dart';

class ColorSchemeDark {
  ColorSchemeDark._();
  static const ColorScheme colorScheme = ColorScheme(
    primary: ColorRes.primaryLight,
    primaryVariant: ColorRes.onPrimaryDark,
    // 小部件的前景色(旋钮、文本、覆盖边缘效果等)。
    secondary: ColorRes.secondaryDark,
    secondaryVariant: ColorRes.secondaryVariantDark,
    surface: ColorRes.surfaceDark,
    background: ColorRes.secondaryHeaderColorDark,
    error: ColorRes.errorColor,
    onPrimary: ColorRes.onBackgroundDark,
    onSecondary: ColorRes.onSecondaryDark,
    onSurface: ColorRes.onSurfaceDark,
    onBackground: ColorRes.onBackgroundDark,
    onError: ColorRes.onErrorDark,
    brightness: Brightness.dark,
  );
}
