import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

/// IndexHintBuilder.
typedef IndexHintBuilder = Widget Function(BuildContext context, String tag);

/// IndexBarDragListener.
abstract class IndexBarDragListener {
  /// Creates an [IndexBarDragListener] that can be used by a
  /// [IndexBar] to return the drag listener.
  factory IndexBarDragListener.create() => IndexBarDragNotifier();

  /// drag details.
  ValueListenable<IndexBarDragDetails> get dragDetails;
}

/// Internal implementation of ItemPositionsListener.
class IndexBarDragNotifier implements IndexBarDragListener {
  @override
  final ValueNotifier<IndexBarDragDetails> dragDetails =
      ValueNotifier(IndexBarDragDetails());
}

/// IndexModel.
class IndexBarDragDetails {
  static const int actionDown = 0;
  static const int actionUp = 1;
  static const int actionUpdate = 2;
  static const int actionEnd = 3;
  static const int actionCancel = 4;

  int? action;
  int? index; //current touch index.
  String? tag; //current touch tag.

  double? localPositionY;
  double? globalPositionY;

  IndexBarDragDetails({
    final this.action,
    final this.index,
    final this.tag,
    final this.localPositionY,
    final this.globalPositionY,
  });
}

///Default Index data.
const List<String> kIndexBarData = [
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z',
  '#'
];

const double kIndexBarWidth = 30;

const double kIndexBarItemHeight = 16;

/// IndexBar options.
class IndexBarOptions {
  /// Creates IndexBar options.
  /// Examples.
  /// needReBuild = true
  /// ignoreDragCancel = true
  /// color = Colors.transparent
  /// downColor = Color(0xFFEEEEEE)
  /// decoration
  /// downDecoration
  /// textStyle = TextStyle(fontSize: 12, color: Color(0xFF666666))
  /// downTextStyle = TextStyle(fontSize: 12, color: Colors.white)
  /// selectTextStyle = TextStyle(fontSize: 12, color: Colors.white)
  /// downItemDecoration =
  /// BoxDecoration(shape: BoxShape.circle, color: Colors.blueAccent)
  /// selectItemDecoration =
  /// BoxDecoration(shape: BoxShape.circle, color: Colors.blueAccent)
  /// indexHintWidth = 72
  /// indexHintHeight = 72
  /// indexHintDecoration =
  /// BoxDecoration(color: Colors.black87, shape: BoxShape.rectangle,
  /// borderRadius: BorderRadius.all(Radius.circular(6)),)
  /// indexHintTextStyle = TextStyle(fontSize: 24.0, color: Colors.white)
  /// indexHintChildAlignment = Alignment.center
  /// indexHintAlignment = Alignment.center
  /// indexHintPosition
  /// indexHintOffset
  /// localImages
  const IndexBarOptions({
    final this.needRebuild = false,
    final this.ignoreDragCancel = false,
    final this.color,
    final this.downColor,
    final this.decoration,
    final this.downDecoration,
    final this.textStyle = const TextStyle(
      fontSize: 12,
      color: Color(0xFF666666),
    ),
    final this.downTextStyle,
    final this.selectTextStyle,
    final this.downItemDecoration,
    final this.selectItemDecoration,
    final this.indexHintWidth = 72,
    final this.indexHintHeight = 72,
    final this.indexHintDecoration = const BoxDecoration(
      color: Colors.black87,
      borderRadius: BorderRadius.all(Radius.circular(6)),
    ),
    final this.indexHintTextStyle =
        const TextStyle(fontSize: 24, color: Colors.white),
    final this.indexHintChildAlignment = Alignment.center,
    final this.indexHintAlignment = Alignment.center,
    final this.indexHintPosition,
    final this.indexHintOffset = Offset.zero,
    final this.localImages = const [],
  });

  /// need to rebuild.
  final bool needRebuild;

  /// Ignore DragCancel.
  final bool ignoreDragCancel;

  /// IndexBar background color.
  final Color? color;

  /// IndexBar down background color.
  final Color? downColor;

  /// IndexBar decoration.
  final Decoration? decoration;

  /// IndexBar down decoration.
  final Decoration? downDecoration;

  /// IndexBar textStyle.
  final TextStyle textStyle;

  /// IndexBar down textStyle.
  final TextStyle? downTextStyle;

  /// IndexBar select textStyle.
  final TextStyle? selectTextStyle;

  /// IndexBar down item decoration.
  final Decoration? downItemDecoration;

  /// IndexBar select item decoration.
  final Decoration? selectItemDecoration;

  /// Index hint width.
  final double indexHintWidth;

  /// Index hint height.
  final double indexHintHeight;

  /// Index hint decoration.
  final Decoration indexHintDecoration;

  /// Index hint alignment.
  final Alignment indexHintAlignment;

  /// Index hint child alignment.
  final Alignment indexHintChildAlignment;

  /// Index hint textStyle.
  final TextStyle indexHintTextStyle;

  /// Index hint position.
  final Offset? indexHintPosition;

  /// Index hint offset.
  final Offset indexHintOffset;

  /// local images.
  final List<String> localImages;
}

/// IndexBarController.
class IndexBarController {
  IndexBarState? _indexBarState;

  bool get isAttached => _indexBarState != null;

  void updateTagIndex(final String tag) {
    _indexBarState?._updateTagIndex(tag);
  }

  void _detach() {
    _indexBarState = null;
  }
}

/// IndexBar.
class IndexBar extends StatefulWidget {
  const IndexBar({
    final Key? key,
    final this.data = kIndexBarData,
    final this.width = kIndexBarWidth,
    final this.height,
    final this.itemHeight = kIndexBarItemHeight,
    final this.margin,
    final this.indexHintBuilder,
    final IndexBarDragListener? indexBarDragListener,
    final this.options = const IndexBarOptions(),
    final this.controller,
  })  : indexBarDragNotifier = indexBarDragListener as IndexBarDragNotifier?,
        super(key: key);

  /// Index data.
  final List<String> data;

  /// IndexBar width(def:30).
  final double width;

  /// IndexBar height.
  final double? height;

  /// IndexBar item height(def:16).
  final double itemHeight;

  /// Empty space to surround the decoration and child.
  final EdgeInsetsGeometry? margin;

  /// IndexHint Builder
  final IndexHintBuilder? indexHintBuilder;

  /// IndexBar drag listener.
  final IndexBarDragNotifier? indexBarDragNotifier;

  /// IndexBar options.
  final IndexBarOptions options;

  /// IndexBarController. If non-null,
  /// this can be used to control the state of the IndexBar.
  final IndexBarController? controller;

  @override
  IndexBarState createState() => IndexBarState();
}

class IndexBarState extends State<IndexBar> {
  /// overlay entry.
  static OverlayEntry? overlayEntry;

  double floatTop = 0;
  String indexTag = '';
  int selectIndex = 0;
  int action = IndexBarDragDetails.actionEnd;

  @override
  void initState() {
    super.initState();
    widget.indexBarDragNotifier?.dragDetails.addListener(_valueChanged);
    widget.controller?._indexBarState = this;
  }

  void _valueChanged() {
    if (widget.indexBarDragNotifier == null) return;
    final details = widget.indexBarDragNotifier!.dragDetails.value;
    selectIndex = details.index!;
    indexTag = details.tag!;
    action = details.action!;
    floatTop = details.globalPositionY! +
        widget.itemHeight / 2 -
        widget.options.indexHintHeight / 2;

    if (_isActionDown()) {
      _addOverlay(context);
    } else {
      _removeOverlay();
    }

    if (widget.options.needRebuild) {
      if (widget.options.ignoreDragCancel &&
          action == IndexBarDragDetails.actionCancel) {
      } else {
        setState(() {});
      }
    }
  }

  bool _isActionDown() =>
      action == IndexBarDragDetails.actionDown ||
      action == IndexBarDragDetails.actionUpdate;

  @override
  void dispose() {
    widget.controller?._detach();
    _removeOverlay();
    widget.indexBarDragNotifier?.dragDetails.removeListener(_valueChanged);
    super.dispose();
  }

  Widget _buildIndexHint(final BuildContext context, final String tag) {
    if (widget.indexHintBuilder != null) {
      return widget.indexHintBuilder!(context, tag);
    }
    Widget child;
    final textStyle = widget.options.indexHintTextStyle;
    final localImages = widget.options.localImages;
    if (localImages.contains(tag)) {
      child = Image.asset(
        tag,
        width: textStyle.fontSize,
        height: textStyle.fontSize,
        color: textStyle.color,
      );
    } else {
      child = Text(tag, style: textStyle);
    }
    return Container(
      width: widget.options.indexHintWidth,
      height: widget.options.indexHintHeight,
      alignment: widget.options.indexHintChildAlignment,
      decoration: widget.options.indexHintDecoration,
      child: child,
    );
  }

  /// add overlay.
  void _addOverlay(final BuildContext context) {
    final overlayState = Overlay.of(context);
    if (overlayState == null) return;
    if (overlayEntry == null) {
      overlayEntry = OverlayEntry(
        builder: (final ctx) {
          double left;
          double top;
          if (widget.options.indexHintPosition != null) {
            left = widget.options.indexHintPosition!.dx;
            top = widget.options.indexHintPosition!.dy;
          } else {
            if (widget.options.indexHintAlignment == Alignment.centerRight) {
              left = MediaQuery.of(context).size.width -
                  kIndexBarWidth -
                  widget.options.indexHintWidth +
                  widget.options.indexHintOffset.dx;
              top = floatTop + widget.options.indexHintOffset.dy;
            } else if (widget.options.indexHintAlignment ==
                Alignment.centerLeft) {
              left = kIndexBarWidth + widget.options.indexHintOffset.dx;
              top = floatTop + widget.options.indexHintOffset.dy;
            } else {
              left = MediaQuery.of(context).size.width / 2 -
                  widget.options.indexHintWidth / 2 +
                  widget.options.indexHintOffset.dx;
              top = MediaQuery.of(context).size.height / 2 -
                  widget.options.indexHintHeight / 2 +
                  widget.options.indexHintOffset.dy;
            }
          }
          return Positioned(
            left: left,
            top: top,
            child: Material(
              color: Colors.transparent,
              child: _buildIndexHint(ctx, indexTag),
            ),
          );
        },
      );
      overlayState.insert(overlayEntry!);
    } else {
      //重新绘制UI，类似setState
      overlayEntry?.markNeedsBuild();
    }
  }

  /// remove overlay.
  void _removeOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  Widget _buildItem(final BuildContext context, final int index) {
    final tag = widget.data[index];
    Decoration? decoration;
    TextStyle? textStyle;
    if (widget.options.downItemDecoration != null) {
      decoration = (_isActionDown() && selectIndex == index)
          ? widget.options.downItemDecoration
          : null;
      textStyle = (_isActionDown() && selectIndex == index)
          ? widget.options.downTextStyle
          : widget.options.textStyle;
    } else if (widget.options.selectItemDecoration != null) {
      decoration =
          (selectIndex == index) ? widget.options.selectItemDecoration : null;
      textStyle = (selectIndex == index)
          ? widget.options.selectTextStyle
          : widget.options.textStyle;
    } else {
      textStyle = _isActionDown()
          ? (widget.options.downTextStyle ?? widget.options.textStyle)
          : widget.options.textStyle;
    }

    Widget child;
    final localImages = widget.options.localImages;
    if (localImages.contains(tag)) {
      child = Image.asset(
        tag,
        width: textStyle?.fontSize,
        height: textStyle?.fontSize,
        color: textStyle?.color,
      );
    } else {
      child = Text(tag, style: textStyle);
    }

    return Container(
      alignment: Alignment.center,
      decoration: decoration,
      child: child,
    );
  }

  void _updateTagIndex(final String tag) {
    if (_isActionDown()) return;
    selectIndex = widget.data.indexOf(tag);
    setState(() {});
  }

  @override
  Widget build(final BuildContext context) => Container(
        color: Colors.transparent,
        decoration: _isActionDown()
            ? widget.options.downDecoration
            : widget.options.decoration,
        width: widget.width + dim20w,
        height: widget.height,
        margin: widget.margin,
        alignment: Alignment.center,
        child: BaseIndexBar(
          data: widget.data,
          width: widget.width,
          itemHeight: widget.itemHeight,
          itemBuilder: _buildItem,
          indexBarDragNotifier: widget.indexBarDragNotifier,
        ),
      );
}

class BaseIndexBar extends StatefulWidget {
  const BaseIndexBar({
    final Key? key,
    final this.data = kIndexBarData,
    final this.width = kIndexBarWidth,
    final this.itemHeight = kIndexBarItemHeight,
    final this.itemBuilder,
    final this.textStyle = const TextStyle(
      fontSize: 12,
      color: Color(0xFF666666),
    ),
    final this.indexBarDragNotifier,
  }) : super(key: key);

  /// index data.
  final List<String> data;

  /// IndexBar width(def:30).
  final double width;

  /// IndexBar item height(def:16).
  final double itemHeight;

  /// IndexBar text style.
  final TextStyle textStyle;

  final IndexedWidgetBuilder? itemBuilder;

  final IndexBarDragNotifier? indexBarDragNotifier;

  @override
  BaseIndexBarState createState() => BaseIndexBarState();
}

class BaseIndexBarState extends State<BaseIndexBar> {
  int lastIndex = -1;
  int _widgetTop = 0;

  /// get index.
  int _getIndex(final double offset) {
    final index = offset ~/ widget.itemHeight;
    return math.min(index, widget.data.length - 1);
  }

  /// trigger drag event.
  void _triggerDragEvent(final int action) {
    widget.indexBarDragNotifier?.dragDetails.value = IndexBarDragDetails(
      action: action,
      index: lastIndex,
      tag: widget.data[lastIndex],
      localPositionY: lastIndex * widget.itemHeight,
      globalPositionY: lastIndex * widget.itemHeight + _widgetTop,
    );
  }

  RenderBox? _getRenderBox(final BuildContext context) {
    final renderObject = context.findRenderObject();
    RenderBox? box;
    if (renderObject != null) {
      box = renderObject as RenderBox;
    }
    return box;
  }

  @override
  Widget build(final BuildContext context) {
    final children = List<Widget>.generate(widget.data.length, (final index) {
      final child = widget.itemBuilder == null
          ? Center(child: Text(widget.data[index], style: widget.textStyle))
          : widget.itemBuilder!(context, index);
      return SizedBox(
        width: widget.width,
        height: widget.itemHeight,
        child: child,
      );
    });

    return GestureDetector(
      onVerticalDragDown: (final details) {
        final box = _getRenderBox(context);
        if (box == null) return;
        final topLeftPosition = box.localToGlobal(Offset.zero);
        _widgetTop = topLeftPosition.dy.toInt();
        final index = _getIndex(details.localPosition.dy);
        if (index >= 0) {
          lastIndex = index;
          _triggerDragEvent(IndexBarDragDetails.actionDown);
        }
      },
      onVerticalDragUpdate: (final details) {
        final index = _getIndex(details.localPosition.dy);
        if (index >= 0 && lastIndex != index) {
          lastIndex = index;
          _triggerDragEvent(IndexBarDragDetails.actionUpdate);
        }
      },
      onVerticalDragEnd: (final details) {
        _triggerDragEvent(IndexBarDragDetails.actionEnd);
      },
      onVerticalDragCancel: () {
        _triggerDragEvent(IndexBarDragDetails.actionCancel);
      },
      onTapUp: (final details) {
        //_triggerDragEvent(IndexBarDragDetails.actionUp);
      },
      behavior: HitTestBehavior.translucent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }
}
