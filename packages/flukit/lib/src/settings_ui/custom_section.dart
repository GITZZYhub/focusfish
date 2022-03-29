import 'package:flutter/material.dart';
import 'abstract_section.dart';

// ignore: must_be_immutable
class CustomSection extends AbstractSection {
  CustomSection({
    final Key? key,
    required final this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(final BuildContext context) => child;
}
