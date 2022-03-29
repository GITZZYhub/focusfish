import 'package:flutter/material.dart';
import '../../resources.dart';

class CheckboxThemeLight {
  CheckboxThemeLight._();
  static final CheckboxThemeData checkboxTheme = CheckboxThemeData(
    fillColor: MaterialStateProperty.all(ColorRes.primaryLight),
  );
}
