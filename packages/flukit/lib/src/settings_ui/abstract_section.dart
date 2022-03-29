import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
abstract class AbstractSection extends StatelessWidget {
  AbstractSection({final Key? key, final this.padding}) : super(key: key);
  
  bool showBottomDivider = false;
  final EdgeInsetsGeometry? padding;
}
