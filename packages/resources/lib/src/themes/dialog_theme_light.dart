import 'package:flutter/material.dart';
import '../../resources.dart';

class DialogThemeLight {
  DialogThemeLight._();

  static final DialogTheme dialogTheme = DialogTheme(
    shape: const RoundedRectangleBorder(
      // side: BorderSide(
      //   color: ColorRes.onSurfaceLight,
      //   width: 0,
      //   style: BorderStyle.none,
      // ),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    backgroundColor: ColorRes.backgroundLight,
    titleTextStyle: TextStyle(
      fontSize: headline6,
      color: ColorRes.textColorLight1,
    ),
    contentTextStyle: TextStyle(
      fontSize: subtitle1,
      color: ColorRes.textColorLight2,
    ),
  );
}
