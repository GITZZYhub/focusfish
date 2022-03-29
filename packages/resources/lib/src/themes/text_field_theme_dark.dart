import 'package:flutter/material.dart';
import '../../resources.dart';

class TextFieldThemeDark {
  TextFieldThemeDark._();
  static const TextSelectionThemeData textSelectionTheme =
      TextSelectionThemeData(
    // 文本框中文本选择的颜色，如TextField
    selectionColor: ColorRes.secondaryDark,
    // 文本框中光标的颜色，如TextField
    cursorColor: ColorRes.cursorColor,
    // 用于调整当前选定的文本部分的句柄的颜色。
    selectionHandleColor: ColorRes.textSelectionHandleColorDark,
  );
}
