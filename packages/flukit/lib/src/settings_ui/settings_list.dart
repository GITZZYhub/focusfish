import 'package:flutter/material.dart';
import 'abstract_section.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({
    final Key? key,
    final this.sections,
    final this.backgroundColor,
    final this.physics,
    final this.shrinkWrap = false,
    final this.lightBackgroundColor,
    final this.darkBackgroundColor,
    final this.contentPadding,
  }) : super(key: key);

  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final List<AbstractSection>? sections;
  final Color? backgroundColor;
  final Color? lightBackgroundColor;
  final Color? darkBackgroundColor;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(final BuildContext context) => Material(
        child: Ink(
          color: Theme.of(context).brightness == Brightness.light
              ? backgroundColor ?? lightBackgroundColor
              : backgroundColor ?? darkBackgroundColor,
          child: ListView.builder(
            physics: physics,
            shrinkWrap: shrinkWrap,
            padding: contentPadding,
            itemCount: sections!.length,
            itemBuilder: (final context, final index) {
              final current = sections![index];
              AbstractSection? futureOne;
              if (index + 1 != sections!.length) {
                futureOne = sections![index + 1];
              }

              // Add divider if title is null
              if (futureOne != null) {
                current.showBottomDivider = false;
                return current;
              } else {
                current.showBottomDivider = true;
                return current;
              }
            },
          ),
        ),
      );
}
