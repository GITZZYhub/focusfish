import 'package:flutter/material.dart';
import '../../resources.dart';

class ElevatedButtonStyleDark {
  ElevatedButtonStyleDark._();

  static final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    padding: EdgeInsets.only(
      top: dim24h,
      bottom: dim24h,
      left: dim48w,
      right: dim48w,
    ),
    minimumSize: const Size(double.minPositive, double.minPositive),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(dim6w)),
    ),
  );
}
