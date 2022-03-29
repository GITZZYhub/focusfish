import 'package:flutter/cupertino.dart';
import '../../resources.dart';

class IconThemeLight {
  IconThemeLight._();
  static final IconThemeData iconTheme = IconThemeData(
    color: ColorRes.iconColorLight,
    opacity: 1,
    size: dim48h,
  );

  static final IconThemeData primaryIconTheme = IconThemeData(
    color: ColorRes.onPrimaryLight,
    opacity: 1,
    size: dim48h,
  );
}
