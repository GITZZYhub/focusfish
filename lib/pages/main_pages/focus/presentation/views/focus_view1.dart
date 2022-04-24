import 'package:common/widgets/progress_bar.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:getx/getx.dart';
import 'package:resources/resources.dart';
import 'package:screen_brightness/screen_brightness.dart';

import '../../focus.dart';

class FocusView extends GetView<FocusController> {
  @override
  Widget build(final BuildContext context) => RouteAwareFocusView(
        controller: controller,
      );
}

class RouteAwareFocusView extends StatefulWidget {
  RouteAwareFocusView({final Key? key, required this.controller})
      : super(key: key);

  final FocusController controller;

  final RouteObserver<Route<dynamic>> routeObserver =
      RouteObserver<Route<dynamic>>();

  @override
  RouteAwareFocusViewState createState() => RouteAwareFocusViewState();
}

class RouteAwareFocusViewState extends State<RouteAwareFocusView>
    with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    ScreenBrightness.resetScreenBrightness();
    widget.routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    super.didPush();
    ScreenBrightness.setScreenBrightness(widget.controller.screenBrightness);
  }

  @override
  void didPushNext() {
    super.didPushNext();
    ScreenBrightness.resetScreenBrightness();
  }

  @override
  void didPop() {
    super.didPop();
    ScreenBrightness.resetScreenBrightness();
  }

  @override
  void didPopNext() {
    super.didPopNext();
    ScreenBrightness.setScreenBrightness(widget.controller.screenBrightness);
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        backgroundColor: const Color(0xff1e232e),
        body: SafeArea(
          child: Obx(
            () => WillPopScope(
              //禁止android返回键和ios侧滑返回
              onWillPop: () async => false,
              child: _buildLongPressWidget(),
            ),
          ),
        ),
      );

  ///长按Widget
  Widget _buildLongPressWidget() => HoldTimeoutDetector(
        onTimeout: () {
        },
        onTimerInitiated: () {
          widget.controller.showButton(isPress: true);
        },
        onCancel: () {
          widget.controller.cancelLongPressTimer();
        },
        onTap: () {
          widget.controller.cancelLongPressTimer();
        },
        holdTimeout: const Duration(milliseconds: 1200),
        enableHapticFeedback: true,
        child: _buildBody(),
      );

  ///主体Widget
  Widget _buildBody() => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: dim60w,
          vertical: dim60h,
        ),
        child: Stack(
          children: [
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: CircularProgressIndicator(
                value: widget.controller.circleProgressValue.value,
              ),
            ),
            // Center(
            //   child: ProgressBar(
            //     backgroundColor: Colors.blue,
            //     valueColor: const AlwaysStoppedAnimation(Colors.grey),
            //     value: 1 -
            //         widget.controller.countDown.value /
            //             widget.controller.staticTime,
            //     timeText: widget.controller.time.value,
            //   ),
            // ),
            if (widget.controller.currentStatus.value == Status.show_button)
              const Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Text(
                  '长按放弃',
                  style: TextStyle(color: Colors.white),
                ),
              ),
          ],
        ),
      );
}
