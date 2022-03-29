import 'package:flutter/material.dart';
import '../../resources.dart';

class TextFieldThemeLight {
  TextFieldThemeLight._();
  static final TextSelectionThemeData textSelectionTheme =
      TextSelectionThemeData(
    // 文本框中文本选择的颜色，如TextField
    selectionColor: ColorRes.appMaterialColorLight.shade200,
    // 文本框中光标的颜色，如TextField
    cursorColor: ColorRes.cursorColor,
    // 用于调整当前选定的文本部分的句柄的颜色。
    selectionHandleColor: ColorRes.appMaterialColorLight.shade300,
  );
}
