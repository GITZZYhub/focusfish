import 'package:common/widgets/bubble_widget.dart';
import 'package:flutter/material.dart';
import 'package:getx/getx.dart';
import 'package:resources/resources.dart';

import '../../result.dart';

class ResultView extends GetView<ResultController> {
  final GlobalKey _bobbleWidgetKey = GlobalKey(debugLabel: 'bobbleWidgetKey');
  @override
  Widget build(final BuildContext context) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              dim40w,
              dim40h,
              dim40w,
              dim100h,
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      controller.goBack();
                    },
                  ),
                ),
                SizedBox(
                  height: dim30h,
                ),
                Center(
                  child: Text('太棒了，专注了${controller.focusTime}'),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: dim10w,
                      vertical: dim30h,
                    ),
                    child: BobbleWidget(
                      key: _bobbleWidgetKey,
                      onClick: () {
                        controller.gotoNextPage();
                      },
                    ),
                  ),
                ),
                const Center(
                  child: Text('主动介入休息，更好精力管理'),
                ),
                const Center(
                  child: Text('戳气泡开始'),
                ),
              ],
            ),
          ),
        ),
      );
}
