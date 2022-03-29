import 'package:common/utils/init_util.dart';
import 'package:flutter/material.dart';
import 'package:getx/getx.dart';
import 'package:resources/resources.dart';

import '../../focus.dart';

class FocusView extends GetView<FocusController> {
  @override
  Widget build(final BuildContext context) => Scaffold(
        body: SafeArea(
          child: WillPopScope(
            //禁止android返回键和ios侧滑返回
            onWillPop: () async => false,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: dim30w,
                vertical: dim50h,
              ),
              child: Column(
                children: [
                  const Spacer(),
                  Obx(
                    () => LinearProgressIndicator(
                      backgroundColor: Colors.blue,
                      valueColor: const AlwaysStoppedAnimation(Colors.grey),
                      value: 1 -
                          controller.countDown.value / controller.staticTime,
                    ),
                  ),
                  Obx(
                    () => Text(controller.time.value),
                  ),
                  const Spacer(),
                  Obx(
                    () => controller.currentStatus.value == Status.running
                        ? ElevatedButton(
                            onPressed: clickDebounce.clickDebounce(() {
                              controller.pause();
                            }),
                            child: const Text('暂停'),
                          )
                        : ElevatedButton(
                            onPressed: clickDebounce.clickDebounce(() {
                              controller.resume();
                            }),
                            child: const Text('继续'),
                          ),
                  ),
                  Obx(
                    () => controller.currentStatus.value == Status.running
                        ? TextButton(
                            onPressed: clickDebounce.clickDebounce(() {
                              controller.gotoNextPage();
                            }),
                            child: const Text('提前完成'),
                          )
                        : TextButton(
                            onLongPress: () {
                              controller.goBack();
                            },
                            onPressed: () {},
                            child: const Text('长按放弃'),
                          ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
