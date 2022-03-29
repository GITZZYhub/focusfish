import 'package:flutter/widgets.dart';

/// Animates the rotation of a widget when [turns]  is changed.

class TurnBox extends StatefulWidget {
  const TurnBox({
    final Key? key,
    final this.turns = .0,
    final this.speed = 200,
    required final this.child,
  }) : super(key: key);

  /// Controls the rotation of the child.
  ///
  /// If the current value of the turns is v, the child will be
  /// rotated v * 2 * pi radians before being painted.
  final double turns;

  /// Animation duration in milliseconds
  final int speed;

  final Widget child;

  @override
  TurnBoxState createState() => TurnBoxState();
}

class TurnBoxState extends State<TurnBox> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      lowerBound: -double.infinity,
      upperBound: double.infinity,
    );
    _controller.value = widget.turns;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => RotationTransition(
        turns: _controller,
        child: widget.child,
      );

  @override
  void didUpdateWidget(final TurnBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.turns != widget.turns) {
      _controller.animateTo(
        widget.turns,
        duration: Duration(milliseconds: widget.speed),
        curve: Curves.easeOut,
      );
    }
  }
}
