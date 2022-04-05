import 'package:flutter/material.dart';

///颜色
class ColorRes {
  ColorRes._();

  ///------------------------- Light -----------------------------------
  static const appMaterialColorLight = MaterialColor(4285161585, {
    50: Color(0xfff2f1f3),
    100: Color(0xffe6e3e8),
    200: Color(0xffcdc8d0),
    300: Color(0xffb4acb9),
    400: Color(0xff9a91a1),
    500: Color(0xff81758a),
    600: Color(0xff675e6e),
    700: Color(0xff4e4653),
    800: Color(0xff342f37),
    900: Color(0xff1a171c)
  });
  static const Color primaryLight = Color(0xff6a6071);
  static const Color secondaryLight = Color(0xff6a6071);
  static const Color secondaryVariantLight = Color(0xff4c4053);
  static const Color backgroundLight = Color(0xfffafafa);
  static const Color surfaceLight = Color(0xffffffff);
  static const Color onPrimaryLight = Color(0xffffffff);
  static const Color onSecondaryLight = Color(0xffffffff);
  static const Color onSurfaceLight = Color(0xff000000);
  static const Color onBackgroundLight = Color(0xffffffff);
  static const Color onErrorLight = Color(0xffffffff);
  static const Color iconColorLight = Color(0xdd000000);

  static Color dividerColorLight = itemDividerColor;
  static const Color highlightColorLight = Color(0x66bcbcbc);
  static const Color splashColorLight = Color(0x66c8c8c8);
  static const Color disabledColorLight = Color(0xFFBCBBC1);
  static const Color hintColorLight = Color(0x8a000000);
  static const Color iosPressedTileColorLight =
      Color.fromRGBO(230, 229, 235, 1);
  static const Color profileLineColorLight = Color(0xff34A853);

  ///------------------------- end -----------------------------------

  ///------------------------- Dark -----------------------------------
  static const appMaterialColorDark = MaterialColor(4280361249, {
    50: Color(0xfff2f2f2),
    100: Color(0xffe6e6e6),
    200: Color(0xffcccccc),
    300: Color(0xffb3b3b3),
    400: Color(0xff999999),
    500: Color(0xff808080),
    600: Color(0xff666666),
    700: Color(0xff4d4d4d),
    800: Color(0xff333333),
    900: Color(0xff191919)
  });
  static const Color primaryDark = Color(0xff212121);
  static const Color primaryVariantDark = Color(0xff9e9e9e);
  static const Color secondaryDark = Color(0xff64ffda);
  static const Color secondaryVariantDark = Color(0xff00bfa5);
  static const Color backgroundDark = Color(0xff303030);
  static const Color surfaceDark = Color(0xff424242);
  static const Color onBackgroundDark = Color(0xffffffff);
  static const Color onErrorDark = Color(0xffffffff);
  static const Color onPrimaryDark = Color(0xff000000);
  static const Color onSecondaryDark = Color(0xff000000);
  static const Color onSurfaceDark = Color(0xffffffff);

  static Color dividerColorDark = itemDividerColor;
  static const Color highlightColorDark = Color(0x40cccccc);
  static const Color splashColorDark = Color(0x40cccccc);
  static const Color disabledColorDark = Color(0xFF6F6A86);
  static const Color hintColorDark = Color(0x80ffffff);
  static const Color secondaryHeaderColorDark = Color(0xff616161);
  static const Color textSelectionHandleColorDark = Color(0xff1de9b6);
  static const Color buttonColorDark = Color(0xff675e6e);
  static const Color buttonHighlightColorDark = Color(0x29ffffff);
  static const Color iosTileDarkColor = Color.fromRGBO(28, 28, 30, 1);
  static const Color iosPressedTileColorDark = Color.fromRGBO(44, 44, 46, 1);

  ///------------------------- end -----------------------------------

  ///------------------------- 通用颜色 -----------------------------------
  static const Color selectedRowColor = Color(0xfff5f5f5);
  static const Color cursorColor = Color(0xff007aff);
  static const Color errorColor = Color(0xffff3b30);
  static const Color errorColorVariant = Color(0xffff0000);
  static const Color textButtonColor = Color(0xff627cfa);
  static const Color iconForwardColor = Color(0xFFC7C7CC);
  static Color itemDividerColor = Colors.grey.shade300;
  static Color tipsColor = Colors.blueAccent;
  static Color warningColor = Colors.orange;

  ///------------------------- end -----------------------------------

  ///------------------------- 字体颜色 -----------------------------------
  static const Color textColorLight1 = Color(0xff000000);
  static const Color textColorLight2 = Color(0xdd000000);
  static const Color textColorLight3 = Color(0x8a000000);

  static const Color textColorDark1 = Color(0xffffffff);
  static const Color textColorDark2 = Color(0xb3ffffff);
  static const Color textColorDark3 = Color(0x5affffff);

  ///------------------------- end -----------------------------------
}
