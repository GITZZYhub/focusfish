import 'package:flutter/material.dart';
import '../../resources.dart';

class AppBarThemeDataLight {
  AppBarThemeDataLight._();
  static final AppBarTheme appBarTheme = AppBarTheme(
    elevation: dim4h,
    backgroundColor: ColorRes.surfaceLight,
    titleTextStyle: TextThemeLight.textTheme.subtitle1,
    iconTheme: IconThemeLight.iconTheme,
    centerTitle: true,
  );
}
