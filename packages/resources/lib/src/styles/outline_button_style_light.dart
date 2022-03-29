import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

class OutlineButtonStyleLight {
  OutlineButtonStyleLight._();

  static final ButtonStyle buttonStyle = OutlinedButton.styleFrom(
    padding: EdgeInsets.only(
      top: dim24h,
      bottom: dim24h,
      left: dim48w,
      right: dim48w,
    ),
    minimumSize: const Size(double.minPositive, double.minPositive),
    side: BorderSide(
      color: ColorRes.secondaryLight,
      width: dim2w,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(dim6w)),
    ),
  );
}
