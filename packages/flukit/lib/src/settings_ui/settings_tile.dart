import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'cupertino_settings_item.dart';

import 'defines.dart';

enum _SettingsTileType { simple, switchTile }

class SettingsTile extends StatelessWidget {
  final String title;
  final int? titleMaxLines;
  final String? subtitle;
  final int? subtitleMaxLines;
  final Widget? leading;
  final Widget? trailing;
  final Icon? iosChevron;
  final EdgeInsetsGeometry? iosChevronPadding;
  final VoidCallback? onPressed;
  // ignore: inference_failure_on_function_return_type
  final Function(bool value)? onToggle;
  final bool? switchValue;
  final bool enabled;
  final TextStyle? titleTextStyle;
  final TextStyle? subtitleTextStyle;
  final Color? switchActiveColor;
  final _SettingsTileType _tileType;

  const SettingsTile({
    final Key? key,
    required final this.title,
    final this.titleMaxLines,
    final this.subtitle,
    final this.subtitleMaxLines,
    final this.leading,
    final this.trailing,
    final this.iosChevron = defaultCupertinoForwardIcon,
    final this.iosChevronPadding,
    final this.titleTextStyle,
    final this.subtitleTextStyle,
    final this.enabled = true,
    final this.onPressed,
    final this.switchActiveColor,
  })  : _tileType = _SettingsTileType.simple,
        onToggle = null,
        switchValue = null,
        assert(titleMaxLines == null || titleMaxLines > 0),
        assert(subtitleMaxLines == null || subtitleMaxLines > 0),
        super(key: key);

  const SettingsTile.switchTile({
    final Key? key,
    required final this.title,
    final this.titleMaxLines,
    final this.subtitle,
    final this.subtitleMaxLines,
    final this.leading,
    final this.enabled = true,
    final this.trailing,
    required final this.onToggle,
    required final this.switchValue,
    final this.titleTextStyle,
    final this.subtitleTextStyle,
    final this.switchActiveColor,
  })  : _tileType = _SettingsTileType.switchTile,
        onPressed = null,
        iosChevron = null,
        iosChevronPadding = null,
        assert(titleMaxLines == null || titleMaxLines > 0),
        assert(subtitleMaxLines == null || subtitleMaxLines > 0),
        super(key: key);

  @override
  Widget build(final BuildContext context) => iosTile(context);

  Widget iosTile(final BuildContext context) {
    if (_tileType == _SettingsTileType.switchTile) {
      return CupertinoSettingsItem(
        enabled: enabled,
        type: SettingsItemType.toggle,
        label: title,
        labelMaxLines: titleMaxLines,
        leading: leading,
        subtitle: subtitle,
        subtitleMaxLines: subtitleMaxLines,
        switchValue: switchValue,
        onToggle: onToggle,
        labelTextStyle: titleTextStyle,
        switchActiveColor: switchActiveColor,
        subtitleTextStyle: subtitleTextStyle,
        valueTextStyle: subtitleTextStyle,
        trailing: trailing,
      );
    } else {
      return CupertinoSettingsItem(
        enabled: enabled,
        type: SettingsItemType.modal,
        label: title,
        labelMaxLines: titleMaxLines,
        value: subtitle,
        trailing: trailing,
        iosChevron: iosChevron,
        iosChevronPadding: iosChevronPadding ?? defaultCupertinoForwardPadding,
        leading: leading,
        onPress: onPressed,
        labelTextStyle: titleTextStyle,
        subtitleTextStyle: subtitleTextStyle,
        valueTextStyle: subtitleTextStyle,
      );
    }
  }
}
