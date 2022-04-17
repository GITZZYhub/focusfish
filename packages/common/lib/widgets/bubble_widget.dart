import 'dart:math';

import 'package:flutter/material.dart';

class BobbleWidget extends StatefulWidget {
  const BobbleWidget({
    Key? key,
    required this.audioTitle,
    required this.onClick,
  }) : super(key: key);

  final List<String> audioTitle;
  final Function(String) onClick;

  @override
  _BobbleWidgetState createState() => _BobbleWidgetState();
}

class _BobbleWidgetState extends State<BobbleWidget>
    with TickerProviderStateMixin {
  //创建的气泡保存集合
  final List<BobbleBean> _list = [];

  //随机数据
  final Random _random = Random(DateTime.now().microsecondsSinceEpoch);

  Size? _widgetSize;
  Offset? _widgetPosition;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _afterLayout();
    });
  }

  void _afterLayout() {
    _getSize();
    _getPosition();

    final maxRadiusPerBobble =
        _widgetSize!.height / widget.audioTitle.length * 0.5;
    for (var index = 0; index < widget.audioTitle.length; index++) {
      BobbleBean particle = BobbleBean();
      particle.content = widget.audioTitle[index];
      //获取随机透明度的颜色
      particle.color = Colors.white; //getRandomColor(_random);
      //随机半径
      particle.radius = (_random.nextInt((maxRadiusPerBobble * 0.2).toInt()) +
              maxRadiusPerBobble)
          .toDouble();
      //确保圆的直径不大于控件宽度的一半
      particle.radius = particle.radius > _widgetSize!.width * 0.25
          ? _widgetSize!.width * 0.25
          : particle.radius;

      //计算圆点位置的边界
      Rect rect = Rect.fromLTRB(
        index % 2 == 0
            ? particle.radius
            : _widgetSize!.width / 2 + particle.radius,
        index == 0
            ? particle.radius + maxRadiusPerBobble * 2 * index
            : maxRadiusPerBobble * 2 * index,
        index % 2 == 0
            ? _widgetSize!.width / 2 - particle.radius
            : _widgetSize!.width - particle.radius,
        index == widget.audioTitle.length - 1
            ? maxRadiusPerBobble * 2 * (index + 1) - particle.radius
            : maxRadiusPerBobble * 2 * (index + 1),
      );
      //指定一个随机位置
      particle.position = Offset(
        (rect.width < 1 ? 0 : _random.nextInt(rect.width.toInt()).toDouble()) +
            rect.left,
        _random.nextInt(rect.height.toInt()).toDouble() + rect.top,
      );
      //集合保存
      _list.add(particle);
    }
  }

  _getSize() {
    final RenderBox renderBox = (widget.key as GlobalKey)
        .currentContext
        ?.findRenderObject() as RenderBox;
    setState(() {
      _widgetSize = renderBox.size;
      debugPrint('_widgetSize:$_widgetSize');
    });
  }

  _getPosition() {
    final RenderBox renderBox = (widget.key as GlobalKey)
        .currentContext
        ?.findRenderObject() as RenderBox;
    setState(() {
      _widgetPosition = renderBox.localToGlobal(Offset.zero);
      debugPrint('_widgetPosition:$_widgetPosition');
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildBubble(context);
  }

  Widget buildBubble(BuildContext context) {
    //使用Stream流实现局部更新
    return _widgetPosition != null
        ? GestureDetector(
            onTapDown: (TapDownDetails details) {
              _list.asMap().forEach((index, bobble) {
                if (details.localPosition.dx <=
                        bobble.position.dx + bobble.radius &&
                    details.localPosition.dx >=
                        bobble.position.dx - bobble.radius &&
                    details.localPosition.dy <=
                        bobble.position.dy + bobble.radius &&
                    details.localPosition.dy >=
                        bobble.position.dy - bobble.radius) {
                  widget.onClick(bobble.content);
                }
              });
            },
            child: CustomPaint(
              //自定义画布
              painter: CustomMyPainter(
                list: _list,
                random: _random,
                upLimit: _widgetPosition!.dy,
                downLimit: _widgetPosition!.dy + _widgetSize!.height,
              ),
              child: Container(
                height: _widgetSize!.height,
              ),
            ),
          )
        : Container();
  }
}

class CustomMyPainter extends CustomPainter {
  //创建画笔
  final Paint _paintFill = Paint();
  final Paint _paintStroke = Paint();
  final TextPainter _textPainter = TextPainter();

  //保存气泡的集合
  List<BobbleBean> list;

  //随机数变量
  Random random;

  double upLimit;
  double downLimit;

  CustomMyPainter({
    required this.list,
    required this.random,
    required this.upLimit,
    required this.downLimit,
  }) {
    _paintFill.isAntiAlias = true;
    _paintStroke
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true
      ..strokeWidth = 2
      ..color = Colors.black;
  }

  @override
  void paint(Canvas canvas, Size size) {
    //循环绘制所有的气泡
    for (var element in list) {
      //填充的颜色
      _paintFill.color = element.color;
      //绘制圆
      canvas.drawCircle(element.position, element.radius, _paintFill);
      canvas.drawCircle(element.position, element.radius, _paintStroke);
      //绘制文字
      double fontSize = element.radius * 0.2;
      final textStyle = TextStyle(
        color: Colors.black,
        fontSize: fontSize,
      );
      final textSpan = TextSpan(
        text: element.content,
        style: textStyle,
      );
      _textPainter
        ..text = textSpan
        ..textDirection = TextDirection.ltr
        ..textAlign = TextAlign.center;
      _textPainter.layout(
        minWidth: element.radius * 2 - fontSize * 2,
        maxWidth: element.radius * 2 - fontSize * 2,
      );

      final offset = Offset(
        element.position.dx - element.radius + fontSize,
        element.position.dy - _textPainter.height * 0.5,
      );
      _textPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

///气泡属性配置
class BobbleBean {
  //位置
  late Offset position;

  //颜色
  late Color color;

  //半径
  late double radius;

  //内容
  late String content;
}
