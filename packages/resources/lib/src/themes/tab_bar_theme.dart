import 'package:flutter/material.dart';
import '../../resources.dart';

class TabBarThemeData {
  TabBarThemeData._();
  static const TabBarTheme tabBarTheme = TabBarTheme(
    indicatorSize: TabBarIndicatorSize.tab,
    labelColor: ColorRes.textColorLight1,
    unselectedLabelColor: ColorRes.textColorLight3,
  );
}
