import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

import 'defines.dart';
import 'settings_tile.dart';

class CupertinoSettingsSection extends StatelessWidget {
  const CupertinoSettingsSection(
    this.items, {
    final this.padding,
    final this.footer,
  });

  final List<SettingsTile> items;

  final EdgeInsetsGeometry? padding;
  final Widget? footer;

  @override
  Widget build(final BuildContext context) {
    final columnChildren = <Widget>[];
    if (padding != null) {
      columnChildren.add(
        Padding(
          padding: padding ?? defaultPadding,
        ),
      );
    }

    final itemsWithDividers = <Widget>[];
    for (var i = 0; i < items.length; i++) {
      final leftPadding = items[i].leading == null ? dim44w : dim60w;
      if (i < items.length - 1) {
        itemsWithDividers
          ..add(items[i])
          ..add(
            Divider(
              height: dim1h,
              thickness: dim1h,
              color: ColorRes.itemDividerColor, //每个item之间线的颜色
              indent: leftPadding,
            ),
          );
      } else {
        itemsWithDividers.add(items[i]);
      }
    }

    final largeScreen = MediaQuery.of(context).size.width >= 768 || false;

    columnChildren.add(
      largeScreen
          ? Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(dim20w)),
                color: Theme.of(context).brightness == Brightness.light
                    ? CupertinoColors.white
                    : ColorRes.iosTileDarkColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: itemsWithDividers,
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: itemsWithDividers,
            ),
    );

    if (footer != null) {
      columnChildren.add(
        DefaultTextStyle(
          style: Theme.of(context).textTheme.caption!,
          child: Padding(
            padding: EdgeInsets.only(
              left: dim16w,
              right: dim16w,
              top: dim8h,
            ),
            child: footer,
          ),
        ),
      );
    }

    return Padding(
      padding: largeScreen
          ? EdgeInsets.only(top: dim40w, left: dim22w, right: dim22w)
          : EdgeInsets.only(
              top: dim30w,
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: columnChildren,
      ),
    );
  }
}
