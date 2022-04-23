import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:common/widgets/rotate_animated_text.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:getx/getx.dart';
import 'package:resources/resources.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:simple_animations/simple_animations.dart';
import 'dart:math';

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
    ScreenBrightness.setScreenBrightnessDelay(
      widget.controller.screenBrightness,
      1000,
    );
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
    ScreenBrightness.setScreenBrightnessDelay(
      widget.controller.screenBrightness,
      1000,
    );
  }

  @override
  Widget build(final BuildContext context) => Obx(
        () => Scaffold(
          backgroundColor: const Color(0xff1e232e),
          body: widget.controller.animateTimerFinish.value
              ? SafeArea(
                  child: WillPopScope(
                    //禁止android返回键和ios侧滑返回
                    onWillPop: () async => false,
                    child: _buildLongPressWidget(),
                  ),
                )
              : FadeView(
                  controller: widget.controller,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
        ),
      );

  ///长按Widget
  Widget _buildLongPressWidget() => HoldTimeoutDetector(
        onTimeout: () {},
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
              alignment: AlignmentDirectional.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: dim100h),
                child: const Text(
                  '想清楚你正在做什么',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: CircularProgressIndicator(
                value: widget.controller.circleProgressValue.value,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: dim100h,
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Text(
                          widget.controller.time.value,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: headline5,
                          ),
                        ),
                        if (widget.controller.plusTime.value)
                          Padding(
                            padding: EdgeInsets.only(left: dim250w),
                            child: DefaultTextStyle(
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: bodyText2,
                              ),
                              child: AnimatedTextKit(
                                totalRepeatCount: 2,
                                pause: Duration.zero,
                                onNext: (final index, final isLast) {
                                  // 中断+1s
                                  widget.controller.setCountDownValue(
                                    widget.controller.countDown.value + 1,
                                  );
                                },
                                animatedTexts: [
                                  MyRotateAnimatedText(
                                    '+1',
                                    duration:
                                        const Duration(milliseconds: 1000),
                                    rotateOut: false,
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (widget.controller.plusTime.value)
                    Container(
                      width: MediaQuery.of(context).size.height * 0.33,
                      height: MediaQuery.of(context).size.height * 0.33,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: GetImage.getDecorationImage(
                          R.gif.interruptGif,
                          BoxFit.contain,
                        ),
                      ),
                    ),
                ],
              ),
            ),
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

class FadeView extends StatefulWidget {
  const FadeView({
    final Key? key,
    required this.controller,
    required this.height,
    required this.width,
  }) : super(key: key);

  final FocusController controller;
  final double height;
  final double width;

  @override
  FadeViewState createState() => FadeViewState();
}

class FadeViewState extends State<FadeView> with TickerProviderStateMixin {
  late Animation<double> _widthAnimation;
  late AnimationController _animationController;

  late Timer _timer;

  bool _isStartAnimation = false;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: Curves.easeOut,
      ),
    );

    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _widthAnimation = Tween<double>(
      begin: widget.height * 0.33,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0,
          1,
        ),
      ),
    );
    _widthAnimation.addStatusListener((final status) {
      if (status == AnimationStatus.completed) {
        // _fadeController.forward();
      }
    });

    _timer = Timer(Duration(seconds: widget.controller.animateTime - 1), () {
      setState(() {
        _isStartAnimation = true;
        _animationController.forward();
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _fadeController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          color: Colors.white,
          child: Stack(
            // fit: StackFit.expand,
            alignment: AlignmentDirectional.center,
            children: [
              Transform.rotate(
                angle: pi / 3,
                child: GetImage.getAssetsImage(
                  widget.controller.fadeImage,
                  height: widget.height * 0.17,
                  width: widget.height * 0.17,
                ),
              ),
              ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(1),
                  BlendMode.srcOut,
                ),
                // This one will create the magic
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        backgroundBlendMode: BlendMode.dstOut,
                      ), // This one will handle background + difference out
                    ),
                    if (!_isStartAnimation)
                      Align(
                        child: Container(
                          height: widget.height * 0.33,
                          width: widget.height * 0.33,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(widget.width),
                            ),
                          ),
                        ),
                      )
                    else
                      AnimatedBuilder(
                        animation: _animationController,
                        builder: (final context, final child) => Align(
                          child: Container(
                            height: _widthAnimation.value,
                            width: _widthAnimation.value,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(widget.width),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
