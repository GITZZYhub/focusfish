import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({final Key? key, final this.height, final this.color})
      : super(key: key);

  final double? height;
  final Color? color;

  @override
  Widget build(final BuildContext context) => Divider(
        height: height ?? dim1h,
        thickness: height ?? dim1h,
        color: color,
      );
}
