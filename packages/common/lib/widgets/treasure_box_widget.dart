import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'dart:ui' as UI;

import 'package:resources/resources.dart';

class TreasureBoxWidget extends StatefulWidget {
  const TreasureBoxWidget({
    Key? key,
    required this.audioTitle,
    required this.onClick,
  }) : super(key: key);

  final List<String> audioTitle;
  final Function(String) onClick;

  @override
  _TreasureBoxWidgetState createState() => _TreasureBoxWidgetState();
}

class _TreasureBoxWidgetState extends State<TreasureBoxWidget>
    with TickerProviderStateMixin {
  //创建的气泡保存集合
  final List<BobbleBean> _list = [];

  //随机数据
  final Random _random = Random(DateTime.now().microsecondsSinceEpoch);

  Size? _widgetSize;
  Offset? _widgetPosition;
  UI.Image? image;

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
      particle.radius *= 0.6;

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

    loadImage()
        .then((img) => image = img)
        .whenComplete(() => setState(() {}));
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
                image: image,
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
  final TextPainter _textPainter = TextPainter();

  //保存气泡的集合
  List<BobbleBean> list;

  //随机数变量
  Random random;

  double upLimit;
  double downLimit;

  UI.Image? image;

  CustomMyPainter({
    required this.list,
    required this.random,
    required this.upLimit,
    required this.downLimit,
    required this.image,
  });

  @override
  void paint(Canvas canvas, Size size) {
    //循环绘制所有的气泡
    for (var element in list) {
      if (image != null) {
        canvas.drawImageRect(
          image!,
          Rect.fromLTRB(
              0, 0, image!.width.toDouble(), image!.height.toDouble()),
          Rect.fromCircle(center: element.position, radius: element.radius),
          Paint(),
        );
      }
      //绘制文字
      double fontSize = element.radius * 0.3;
      final textStyle = TextStyle(
        color: Colors.white,
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
        element.position.dy + element.radius + _textPainter.height * 0.5,
      );
      _textPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

// 获取图片
Future<UI.Image> loadImage() async {
  ImageStream stream = AssetImage(R.png.treasureBoxBig, package: 'resources')
      .resolve(ImageConfiguration.empty);
  Completer<UI.Image> completer = Completer<UI.Image>();
  void listener(ImageInfo frame, bool synchronousCall) {
    final UI.Image image = frame.image;
    completer.complete(image);
    stream.removeListener(ImageStreamListener(listener));
  }

  stream.addListener(ImageStreamListener(listener));
  return completer.future;
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
