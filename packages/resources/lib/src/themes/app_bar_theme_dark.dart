import 'package:flutter/material.dart';
import '../../resources.dart';

class AppBarThemeDataDark {
  AppBarThemeDataDark._();
  static final AppBarTheme appBarTheme = AppBarTheme(
    elevation: dim4h,
    backgroundColor: ColorRes.primaryDark,
    titleTextStyle: TextThemeDark.textTheme.subtitle1,
    centerTitle: true,
  );
}
