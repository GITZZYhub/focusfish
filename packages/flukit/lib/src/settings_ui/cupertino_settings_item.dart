import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

import 'defines.dart';

enum SettingsItemType {
  toggle,
  modal,
}

typedef PressOperationCallback = void Function();

const _spacer = Expanded(child: SizedBox.shrink());

class CupertinoSettingsItem extends StatefulWidget {
  const CupertinoSettingsItem({
    required final this.type,
    required final this.label,
    final this.labelMaxLines,
    final this.subtitle,
    final this.subtitleMaxLines,
    final this.leading,
    final this.trailing,
    final this.iosChevron = defaultCupertinoForwardIcon,
    final this.iosChevronPadding,
    final this.value,
    final this.hasDetails = false,
    final this.enabled = true,
    final this.onPress,
    final this.switchValue = false,
    final this.onToggle,
    final this.labelTextStyle,
    final this.subtitleTextStyle,
    final this.valueTextStyle,
    final this.switchActiveColor,
  })  : assert(labelMaxLines == null || labelMaxLines > 0),
        assert(subtitleMaxLines == null || subtitleMaxLines > 0);

  final String label;
  final int? labelMaxLines;
  final String? subtitle;
  final int? subtitleMaxLines;
  final Widget? leading;
  final Widget? trailing;
  final Icon? iosChevron;
  final EdgeInsetsGeometry? iosChevronPadding;
  final SettingsItemType type;
  final String? value;
  final bool hasDetails;
  final bool enabled;
  final PressOperationCallback? onPress;
  final bool? switchValue;
  // ignore: inference_failure_on_function_return_type
  final Function(bool value)? onToggle;
  final TextStyle? labelTextStyle;
  final TextStyle? subtitleTextStyle;
  final TextStyle? valueTextStyle;
  final Color? switchActiveColor;

  @override
  State<StatefulWidget> createState() => CupertinoSettingsItemState();
}

class CupertinoSettingsItemState extends State<CupertinoSettingsItem> {
  bool pressed = false;
  bool? _checked;

  @override
  Widget build(final BuildContext context) {
    _checked = widget.switchValue;

    /// The width of iPad. This is used to make circular borders on iPad and web
    final isLargeScreen = MediaQuery.of(context).size.width >= 768;

    final theme = Theme.of(context);
    final tileTheme = ListTileTheme.of(context);

    final iconThemeData = IconThemeData(
      color: widget.enabled
          ? _iconColor(theme, tileTheme)
          : CupertinoColors.inactiveGray,
    );

    Widget? leadingIcon;
    if (widget.leading != null) {
      leadingIcon = IconTheme.merge(
        data: iconThemeData,
        child: widget.leading!,
      );
    }

    final rowChildren = <Widget>[];
    if (leadingIcon != null) {
      rowChildren.add(
        Padding(
          padding: EdgeInsetsDirectional.only(
            start: dim44w,
          ),
          child: leadingIcon,
        ),
      );
    }

    final Widget titleSection;

    if (widget.subtitle == null) {
      titleSection = Text(
        widget.label,
        overflow: TextOverflow.ellipsis,
        style: widget.labelTextStyle ?? Theme.of(context).textTheme.bodyText2,
      );
    } else {
      titleSection = Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.label,
            overflow: TextOverflow.ellipsis,
            style: widget.labelTextStyle,
          ),
          SizedBox(height: dim2h),
          Text(
            widget.subtitle!,
            maxLines: widget.subtitleMaxLines,
            overflow: TextOverflow.ellipsis,
            style:
                widget.subtitleTextStyle ?? Theme.of(context).textTheme.caption,
          ),
        ],
      );
    }

    rowChildren.add(
      Expanded(
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            start: dim44w,
            end: dim44w,
          ),
          child: titleSection,
        ),
      ),
    );

    switch (widget.type) {
      case SettingsItemType.toggle:
        rowChildren.add(
          Padding(
            padding: EdgeInsetsDirectional.only(end: dim24w),
            child: CupertinoSwitch(
              value: widget.switchValue!,
              activeColor: widget.enabled
                  ? (widget.switchActiveColor ?? Theme.of(context).accentColor)
                  : CupertinoColors.inactiveGray,
              onChanged: !widget.enabled
                  ? null
                  : (final value) {
                      widget.onToggle!(value);
                    },
            ),
          ),
        );
        break;

      case SettingsItemType.modal:
        if (widget.value == null) {
          rowChildren.add(_spacer);
        } else {
          rowChildren.add(
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                  top: dim4h,
                  end: dim8w,
                ),
                child: Text(
                  widget.value!,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                  style: widget.valueTextStyle ??
                      Theme.of(context).textTheme.caption,
                ),
              ),
            ),
          );
        }

        final endRowChildren = <Widget>[];
        if (widget.trailing != null) {
          endRowChildren.add(
            Padding(
              padding: EdgeInsetsDirectional.only(
                top: dim2h,
                start: dim4w,
              ),
              child: widget.trailing,
            ),
          );
        }

        final iosChevron = widget.iosChevron;
        if (widget.trailing == null && iosChevron != null) {
          endRowChildren.add(
            widget.iosChevronPadding == null
                ? iosChevron
                : Padding(
                    padding: widget.iosChevronPadding!,
                    child: iosChevron,
                  ),
          );
        }

        endRowChildren.add(SizedBox(width: dim8w));

        rowChildren.add(
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: endRowChildren,
          ),
        );
        break;
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if ((widget.onPress != null || widget.onToggle != null) &&
            widget.enabled) {
          if (mounted) {
            setState(() {
              pressed = true;
            });
          }

          widget.onPress?.call();

          Future.delayed(const Duration(milliseconds: 100), () {
            if (mounted) {
              setState(() {
                pressed = false;
              });
            }
          });
        }

        if (widget.type == SettingsItemType.toggle && widget.enabled) {
          if (mounted) {
            setState(() {
              _checked = !_checked!;
              widget.onToggle!(_checked!);
            });
          }
        }
      },
      onTapUp: (final _) {
        if (widget.enabled && mounted) {
          setState(() {
            pressed = false;
          });
        }
      },
      onTapDown: (final _) {
        if (widget.enabled && mounted) {
          setState(() {
            pressed = true;
          });
        }
      },
      onTapCancel: () {
        if (widget.enabled && mounted) {
          setState(() {
            pressed = false;
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius:
              isLargeScreen ? BorderRadius.all(Radius.circular(dim40w)) : null,
          color: calculateBackgroundColor(context),
        ),
        height: widget.subtitle == null ? dim120h : dim160h,
        child: Row(
          children: rowChildren,
        ),
      ),
    );
  }

  Color calculateBackgroundColor(final BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? pressed
              ? ColorRes.iosPressedTileColorLight
              : Colors.white
          : pressed
              ? ColorRes.iosPressedTileColorDark
              : ColorRes.iosTileDarkColor;

  Color? _iconColor(final ThemeData theme, final ListTileThemeData tileTheme) {
    if (tileTheme.selectedColor != null) {
      return tileTheme.selectedColor;
    }

    if (tileTheme.iconColor != null) {
      return tileTheme.iconColor;
    }

    switch (theme.brightness) {
      case Brightness.light:
        return Colors.black45;
      case Brightness.dark:
        return null; // null - use current icon theme color
    }
  }
}
