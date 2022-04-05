import 'package:flutter/material.dart';
import 'package:getx/getx.dart';
import 'package:resources/resources.dart';

import '../../rest.dart';

class RestView extends GetView<RestController> {
  @override
  Widget build(final BuildContext context) => Scaffold(
        backgroundColor: Colors.indigoAccent,
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
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      controller.goBack();
                    },
                  ),
                ),
                SizedBox(
                  height: dim30h,
                ),
                const Center(
                  child: Text(
                    '剩余休息时间：',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Obx(
                  () => Center(
                    child: Text(
                      controller.time.value,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: dim300w,
                    height: dim300h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: dim2w,
                      ),
                    ),
                    child: const Center(
                      child: Text('5分钟冥想'),
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    '休息完成',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const Center(
                  child: Text(
                    '将自动开始专注',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
