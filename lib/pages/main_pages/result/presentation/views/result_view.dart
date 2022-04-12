import 'package:common/widgets/bubble_widget.dart';
import 'package:flutter/material.dart';
import 'package:getx/getx.dart';
import 'package:resources/resources.dart';

import '../../result.dart';

class ResultView extends GetView<ResultController> {
  final GlobalKey _bobbleWidgetKey = GlobalKey(debugLabel: 'bobbleWidgetKey');

  @override
  Widget build(final BuildContext context) => Scaffold(
        backgroundColor: const Color(0xff1e232e),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '时间剩余：',
                      style: TextStyle(color: Colors.white),
                    ),
                    Obx(
                      () => Text(
                        controller.time.value,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
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
                        controller.gotoRest();
                      },
                    ),
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      controller.gotoFocus();
                    },
                    child: const Text(
                      '跳过休息',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    '主动休息是更好的精力管理',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
