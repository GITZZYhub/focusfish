import 'package:flutter/material.dart';
import '../../resources.dart';

class TextButtonStyleDark {
  TextButtonStyleDark._();

  static final ButtonStyle buttonStyle = TextButton.styleFrom(
    primary: ColorRes.textButtonColor,
    onSurface: ColorRes.textButtonColor,
    padding: EdgeInsets.only(
      top: dim4h,
      bottom: dim4h,
      left: dim4w,
      right: dim4w,
    ),
    minimumSize: const Size(double.minPositive, double.minPositive),
  );
}
