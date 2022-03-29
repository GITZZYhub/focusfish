import 'package:common/widgets/pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:getx/getx.dart';
import 'package:resources/resources.dart';

import '../../my_data.dart';

class MyDataView extends GetView<MyDataController> {
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
                    const Expanded(
                      child: Center(
                        child: Text('我的数据'),
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
                  child: Text('Name: 小姜'),
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
