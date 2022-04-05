import 'package:common/utils/init_util.dart';
import 'package:common/widgets/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:getx/getx.dart';
import 'package:resources/resources.dart';

import '../../focus.dart';

class FocusView extends GetView<FocusController> {
  @override
  Widget build(final BuildContext context) => Scaffold(
        backgroundColor: Colors.indigoAccent,
        body: SafeArea(
          child: WillPopScope(
            //禁止android返回键和ios侧滑返回
            onWillPop: () async => false,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: dim60w,
                vertical: dim60h,
              ),
              child: Column(
                children: [
                  const Spacer(),
                  Obx(
                    () => ProgressBar(
                      backgroundColor: Colors.blue,
                      valueColor: const AlwaysStoppedAnimation(Colors.grey),
                      value: 1 -
                          controller.countDown.value / controller.staticTime,
                      timeText: controller.time.value,
                    ),
                  ),
                  const Spacer(),
                  Obx(
                    () => controller.currentStatus.value == Status.running
                        ? IconButton(
                            onPressed: clickDebounce.clickDebounce(() {
                              controller.pause();
                            }),
                            padding: EdgeInsets.zero,
                            icon: GetImage.getSvgImage(
                              R.svg.pause,
                              size: dim160w,
                            ),
                          )
                        : IconButton(
                            onPressed: clickDebounce.clickDebounce(() {
                              controller.resume();
                            }),
                            padding: EdgeInsets.zero,
                            icon: GetImage.getSvgImage(
                              R.svg.play,
                              size: dim160w,
                            ),
                          ),
                  ),
                  Obx(
                    () => controller.currentStatus.value == Status.running
                        ? TextButton(
                            onPressed: clickDebounce.clickDebounce(() {
                              controller.gotoNextPage();
                            }),
                            child: const Text(
                              '提前完成',
                              style: TextStyle(color: Colors.amberAccent),
                            ),
                          )
                        : TextButton(
                            onLongPress: () {
                              controller.goBack();
                            },
                            onPressed: () {},
                            child: const Text(
                              '长按放弃',
                              style: TextStyle(color: Colors.amberAccent),
                            ),
                          ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
