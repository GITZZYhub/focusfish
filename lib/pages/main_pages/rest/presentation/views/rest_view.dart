import 'package:common/audio_services/notifiers/notifiers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getx/getx.dart';
import 'package:resources/resources.dart';

import '../../rest.dart';

class RestView extends GetView<RestController> {
  @override
  Widget build(final BuildContext context) => Scaffold(
        backgroundColor: const Color(0xff1e232e),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              dim60w,
              dim40h,
              dim60w,
              dim200h,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '时间剩余：',
                      style: TextStyle(color: Colors.white),
                    ),
                    ValueListenableBuilder<ButtonState>(
                      valueListenable:
                          controller.audioManager.playButtonNotifier,
                      builder: (final _, final value, final __) {
                        switch (value) {
                          case ButtonState.loading:
                            return const CupertinoActivityIndicator();
                          case ButtonState.paused:
                          case ButtonState.playing:
                            return ValueListenableBuilder<ProgressBarState>(
                              valueListenable:
                                  controller.audioManager.progressNotifier,
                              builder: (final _, final value, final __) => Text(
                                RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                                        .firstMatch(
                                          '${value.total - value.current}',
                                        )
                                        ?.group(1) ??
                                    '${value.total - value.current}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            );
                        }
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: Image.asset(
                    R.png.mantuoluo,
                    package: 'resources',
                  ),
                ),
                Center(
                  child: Text(
                    controller.audioItem['title'] ?? '',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
