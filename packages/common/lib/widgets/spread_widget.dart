import 'package:flutter/material.dart';
import 'dart:async';
import 'package:eventbus/eventbus.dart';

import '../event/redraw_water_animation.dart';

class SpreadWidget extends StatefulWidget {
  const SpreadWidget({
    Key? key,
    this.child,
    required this.radius,
    required this.maxRadius,
    this.cycles,
    this.spreadColor = Colors.grey,
    this.duration = const Duration(milliseconds: 3000),
  }) : super(key: key);

  final Widget? child;
  final double radius;
  final double maxRadius;
  final int? cycles;
  final Color spreadColor;
  final Duration duration;

  @override
  _SpreadWidgetState createState() => _SpreadWidgetState();
}

class _SpreadWidgetState extends State<SpreadWidget>
    with TickerProviderStateMixin {
  List<Widget> children = [];
  List<AnimationController> controllers = [];

  @override
  void initState() {
    super.initState();
    if (widget.child != null) {
      children.add(
        ClipOval(
          child: SizedBox(
            width: widget.radius,
            height: widget.radius,
            child: widget.child,
          ),
        ),
      );
    }
    start();
  }

  start() async {
    int i = 0;
    while (widget.cycles == null ? true : i < (widget.cycles ?? 1)) {
      if (mounted) {
        setState(() {
          AnimationController _animationController;
          Animation<double> _animation;

          _animationController =
              AnimationController(vsync: this, duration: widget.duration);
          _animation = CurvedAnimation(
              parent: _animationController, curve: Curves.linear);

          _animationController.addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              children.removeAt(0);
              controllers.removeAt(0);
              _animationController.dispose();
            }
          });
          controllers.add(_animationController);
          _animationController.forward();

          widget.child != null
              ? children.insert(
                  children.length - 1,
                  AnimatedSpread(
                    animation: _animation,
                    radius: widget.radius,
                    maxRadius: widget.maxRadius,
                    color: widget.spreadColor,
                  ))
              : children.add(AnimatedSpread(
                  animation: _animation,
                  radius: widget.radius,
                  maxRadius: widget.maxRadius,
                  color: widget.spreadColor,
                ));
        });
      }
      if (widget.cycles != null) i++;
      await Future.delayed(
          Duration(milliseconds: widget.duration.inMilliseconds ~/ 3));
    }
  }

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: children,
      alignment: Alignment.center,
    );
  }
}

class AnimatedSpread extends AnimatedWidget {
  final Tween<double> _opacityTween = Tween(begin: 1, end: 0);
  final Tween<double> _radiusTween;
  final Color color;
  final Animation<double> animation;

  AnimatedSpread(
      {Key? key,
      required this.animation,
      required double radius,
      required double maxRadius,
      required this.color})
      : _radiusTween = Tween(begin: radius, end: maxRadius),
        super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _radiusTween.evaluate(animation),
      height: _radiusTween.evaluate(animation),
      child: ClipOval(
        child: Opacity(
          opacity: _opacityTween.evaluate(animation),
          child: Container(
            color: color,
          ),
        ),
      ),
    );
  }
}

class WaterRipples extends StatefulWidget {
  const WaterRipples({
    Key? key,
    required this.radius,
    required this.maxRadius,
    required this.title,
  }) : super(key: key);

  final double radius;
  final double maxRadius;
  final String title;

  @override
  State<StatefulWidget> createState() => _WaterRipplesState();
}

class _WaterRipplesState extends State<WaterRipples>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  //动画控制器
  final List<AnimationController> _controllers = [];

  //动画控件集合
  final List<Widget> _children = [];

  //添加蓝牙检索动画计时器
  Timer? _searchBluetoothTimer;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.maxRadius,
      height: widget.maxRadius,
      child: Stack(
        alignment: Alignment.center,
        children: _children,
      ),
    );
  }

  ///初始化蓝牙检索动画，依次添加5个缩放动画，形成水波纹动画效果
  void _startAnimation() {
    //动画启动前确保_children控件总数为0
    _children.clear();
    //添加第一个圆形缩放动画
    _addSearchAnimation(true);
    //以后每隔1秒，再次添加一个缩放动画，总共添加4个
    _searchBluetoothTimer =
        Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      _addSearchAnimation(true);
      if (timer.tick >= 4) {
        timer.cancel();
      }
    });
  }

  ///init: 首次添加5个基本控件时，=true，
  void _addSearchAnimation(bool init) {
    var controller = _createController();
    _controllers.add(controller);
    var animation = Tween(begin: widget.radius, end: widget.maxRadius)
        .animate(CurvedAnimation(parent: controller, curve: Curves.linear));
    if (!init) {
      //5个基本动画控件初始化完成的情况下，每次添加新的动画控件时，移除第一个，确保动画控件始终保持5个
      if (_children.isNotEmpty) {
        _children.removeAt(0);
      }
      //添加新的动画控件
      Future.delayed(const Duration(seconds: 1), () {
        if (!mounted) return;
        //动画页面没有执行退出情况下，继续添加动画
        _children.add(_getAnimatedBuilder(controller, animation));
        try {
          //动画页退出时，捕获可能发生的异常
          controller.forward();
          setState(() {});
        } catch (e) {
          return;
        }
      });
    } else {
      _children.add(_getAnimatedBuilder(controller, animation));
      controller.forward();
      setState(() {});
    }
  }

  AnimatedBuilder _getAnimatedBuilder(final controller, final animation) =>
      AnimatedBuilder(
          animation: controller,
          builder: (BuildContext context, Widget? child) {
            return Opacity(
              opacity: 1.0 -
                  ((animation.value - widget.radius) /
                      (widget.maxRadius - widget.radius)),
              child: ClipOval(
                child: Container(
                  width: animation.value,
                  height: animation.value,
                  color: const Color(0xff9fbaff),
                  child: Center(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            );
          });

  ///创建蓝牙检索动画控制器
  AnimationController _createController() {
    var controller = AnimationController(
        duration: const Duration(milliseconds: 4000), vsync: this);
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
        if (_controllers.contains(controller)) {
          _controllers.remove(controller);
        }
        //每次动画控件结束时，添加新的控件，保持动画的持续性
        if (mounted) _addSearchAnimation(false);
      }
    });
    return controller;
  }

  ///监听应用状态，
  /// 生命周期变化时回调
  /// resumed:应用可见并可响应用户操作
  /// inactive:用户可见，但不可响应用户操作
  /// paused:已经暂停了，用户不可见、不可操作
  /// suspending：应用被挂起，此状态IOS永远不会回调
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      //应用退至后台，销毁蓝牙检索动画
      _disposeSearchAnimation();
    } else if (state == AppLifecycleState.resumed) {
      //应用回到前台，重新启动动画
      _startAnimation();
    }
  }

  ///销毁动画
  void _disposeSearchAnimation() {
    //释放动画所有controller
    for (var element in _controllers) {
      element.dispose();
    }
    _controllers.clear();
    _searchBluetoothTimer?.cancel();
    _children.clear();
  }

  @override
  void initState() {
    super.initState();
    _startAnimation();
    //添加应用生命周期监听
    WidgetsBinding.instance!.addObserver(this);
    eventBus.on<RedrawWaterAnimationEvent>().listen((event) {
      _disposeSearchAnimation();
      _startAnimation();
    });
  }

  @override
  void dispose() {
    //销毁动画
    _disposeSearchAnimation();
    //销毁应用生命周期观察者
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }
}
