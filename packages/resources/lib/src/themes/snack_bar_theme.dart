import 'package:flutter/material.dart';
import '../../resources.dart';

class SnackBarTheme {
  SnackBarTheme._();
  static final SnackBarThemeData snackBarTheme = SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    backgroundColor: Color.alphaBlend(
      Colors.black.withOpacity(0.80),
      Colors.white,
    ),
    contentTextStyle:
        TextStyle(fontSize: subtitle1, color: Colors.white),
  );
}
