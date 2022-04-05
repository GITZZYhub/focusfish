import 'dart:math';

import 'package:common/utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

class ProgressBar extends StatefulWidget {
  const ProgressBar({
    Key? key,
    this.backgroundColor,
    this.valueColor,
    required this.value,
    this.timeText,
  }) : super(key: key);

  final Color? backgroundColor;
  final Animation<Color?>? valueColor;
  final double value;
  final String? timeText;

  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.centerStart,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: dim100w,
          ),
          child: LinearProgressIndicator(
            backgroundColor: widget.backgroundColor,
            valueColor: widget.valueColor,
            value: widget.value,
          ),
        ),
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Padding(
            padding: EdgeInsets.only(
              right: dim40w,
            ),
            child: GetImage.getAssetsImage(
              R.png.treasureBox,
              width: dim80w,
              height: dim80h,
            ),
          ),
        ),
        LayoutBuilder(
          builder: (
            final context,
            final constrains,
          ) {
            final leftPadding =
                (constrains.maxWidth - dim100w * 2) * widget.value + dim50w;
            return Padding(
              padding: EdgeInsets.only(
                left: leftPadding,
              ),
              child: GetImage.getAssetsImage(
                R.png.progressWhale,
                width: dim60w,
                height: dim40h,
              ),
            );
          },
        ),
        LayoutBuilder(
          builder: (
            final context,
            final constrains,
          ) {
            final leftPadding =
                (constrains.maxWidth - dim100w * 2) * widget.value;
            return Padding(
              padding: EdgeInsets.only(
                top: dim120h,
                left: leftPadding,
              ),
              child: Text(
                widget.timeText ?? '',
                style: TextStyle(fontSize: headline5, color: Colors.white),
              ),
            );
          },
        ),
      ],
    );
  }
}
