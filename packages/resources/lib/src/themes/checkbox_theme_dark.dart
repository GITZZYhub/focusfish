import 'package:flutter/material.dart';
import '../../resources.dart';

class CheckboxThemeDark {
  CheckboxThemeDark._();
  static final CheckboxThemeData checkboxTheme = CheckboxThemeData(
    fillColor: MaterialStateProperty.all(ColorRes.secondaryDark),
  );
}
