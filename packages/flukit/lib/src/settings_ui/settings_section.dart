import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'abstract_section.dart';
import 'cupertino_settings_section.dart';
import 'defines.dart';
import 'settings_tile.dart';

// ignore: must_be_immutable
class SettingsSection extends AbstractSection {
  SettingsSection({
    final Key? key,
    final EdgeInsetsGeometry? padding,
    final this.maxLines,
    final this.subtitle,
    final this.subtitlePadding,
    final this.tiles,
    final this.titleTextStyle,
  })  : assert(maxLines == null || maxLines > 0),
        super(key: key, padding: padding);

  final List<SettingsTile>? tiles;
  final TextStyle? titleTextStyle;
  final int? maxLines;
  final Widget? subtitle;
  final EdgeInsetsGeometry? subtitlePadding;

  @override
  Widget build(final BuildContext context) => iosSection();

  Widget iosSection() => CupertinoSettingsSection(
        tiles!,
        padding: padding ?? defaultPadding,
      );
}
