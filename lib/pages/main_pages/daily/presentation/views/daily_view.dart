import 'package:common/widgets/pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:getx/getx.dart';
import 'package:resources/resources.dart';

import '../../daily.dart';

class DailyView extends GetView<DailyController> {
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
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        controller.goBack();
                      },
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                          children: [
                            const Text('日报'),
                            SizedBox(
                              height: dim10h,
                            ),
                            const Text(
                              '更新',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.share),
                    )
                  ],
                ),
                SizedBox(
                  height: dim30h,
                ),
                const Center(
                  child: Text('太棒了！有5个小时没有摸鱼'),
                ),
                const Expanded(
                  child: MyPieChart(),
                ),
              ],
            ),
          ),
        ),
      );
}
