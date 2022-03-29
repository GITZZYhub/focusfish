// Copyright 2018 Simon Lightfoot. All rights reserved.
// Use of this source code is governed by a the MIT license that can be
// found in the LICENSE file.

import 'dart:math' show min, max;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Called every layout to provide the amount of stickyness a header is in.
/// This lets the widgets animate their content and provide feedback.
///
typedef RenderStickyHeaderCallback = void Function(double stuckAmount);

/// RenderObject for StickyHeader widget.
///
/// Monitors given [Scrollable] and adjusts its layout based on its offset to
/// the scrollable's [RenderObject]. The header will be placed above content
/// unless overlapHeaders is set to true. The supplied callback will be used
/// to report the
///
class RenderStickyHeader extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, MultiChildLayoutParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, MultiChildLayoutParentData> {
  RenderStickyHeaderCallback? _callback;
  ScrollPosition _scrollPosition;
  bool _overlapHeaders;

  RenderStickyHeader({
    required final ScrollPosition scrollPosition,
    final RenderStickyHeaderCallback? callback,
    final bool overlapHeaders = false,
    final RenderBox? header,
    final RenderBox? content,
  })  : _scrollPosition = scrollPosition,
        _callback = callback,
        _overlapHeaders = overlapHeaders {
    if (content != null) add(content);
    if (header != null) add(header);
  }

  ScrollPosition get scrollPosition => _scrollPosition;
  set scrollPosition(final ScrollPosition newValue) {
    if (_scrollPosition == newValue) {
      return;
    }
    final oldValue = _scrollPosition;
    _scrollPosition = newValue;
    markNeedsLayout();
    if (attached) {
      oldValue.removeListener(markNeedsLayout);
      newValue.addListener(markNeedsLayout);
    }
  }

  RenderStickyHeaderCallback? get callback => _callback;
  set callback(final RenderStickyHeaderCallback? newValue) {
    if (_callback == newValue) {
      return;
    }
    _callback = newValue;
    markNeedsLayout();
  }

  bool get overlapHeaders => _overlapHeaders;
  set overlapHeaders(final bool newValue) {
    if (_overlapHeaders == newValue) {
      return;
    }
    _overlapHeaders = newValue;
    markNeedsLayout();
  }

  @override
  void attach(final PipelineOwner owner) {
    super.attach(owner);
    _scrollPosition.addListener(markNeedsLayout);
  }

  @override
  void detach() {
    _scrollPosition.removeListener(markNeedsLayout);
    super.detach();
  }

  // short-hand to access the child RenderObjects
  RenderBox get _headerBox => lastChild!;

  RenderBox get _contentBox => firstChild!;

  @override
  void performLayout() {
    // ensure we have header and content boxes
    assert(childCount == 2);

    // layout both header and content widget
    final childConstraints = constraints.loosen();
    _headerBox.layout(childConstraints, parentUsesSize: true);
    _contentBox.layout(childConstraints, parentUsesSize: true);

    final headerHeight = _headerBox.size.height;
    final contentHeight = _contentBox.size.height;

    // determine size of ourselves based on content widget
    final width = max(constraints.minWidth, _contentBox.size.width);
    final height = max(
      constraints.minHeight,
      _overlapHeaders ? contentHeight : headerHeight + contentHeight,
    );
    size = Size(width, height);
    assert(size.width == constraints.constrainWidth(width));
    assert(size.height == constraints.constrainHeight(height));
    assert(size.isFinite);

    // place content underneath header
    final contentParentData =
        _contentBox.parentData as MultiChildLayoutParentData?;
    contentParentData?.offset = Offset(0, _overlapHeaders ? 0.0 : headerHeight);

    // determine by how much the header should be stuck to the top
    final stuckOffset = determineStuckOffset();

    // place header over content relative to scroll offset
    final maxOffset = height - headerHeight;
    final headerParentData =
        _headerBox.parentData as MultiChildLayoutParentData?;
    headerParentData?.offset = Offset(0, max(0, min(-stuckOffset, maxOffset)));

    // report to widget how much the header is stuck.
    if (_callback != null) {
      final stuckAmount =
          max(min(headerHeight, stuckOffset), -headerHeight) / headerHeight;
      _callback!(stuckAmount);
    }
  }

  double determineStuckOffset() {
    final scrollBox =
        _scrollPosition.context.notificationContext!.findRenderObject();
    if (scrollBox?.attached ?? false) {
      try {
        return localToGlobal(Offset.zero, ancestor: scrollBox).dy;
      } on Exception {
        // ignore and fall-through and return 0.0
      }
    }
    return 0;
  }

  @override
  void setupParentData(final RenderObject child) {
    super.setupParentData(child);
    if (child.parentData is! MultiChildLayoutParentData) {
      child.parentData = MultiChildLayoutParentData();
    }
  }

  @override
  double computeMinIntrinsicWidth(final double height) =>
      _contentBox.getMinIntrinsicWidth(height);

  @override
  double computeMaxIntrinsicWidth(final double height) =>
      _contentBox.getMaxIntrinsicWidth(height);

  @override
  double computeMinIntrinsicHeight(final double width) => _overlapHeaders
      ? _contentBox.getMinIntrinsicHeight(width)
      : (_headerBox.getMinIntrinsicHeight(width) +
          _contentBox.getMinIntrinsicHeight(width));

  @override
  double computeMaxIntrinsicHeight(final double width) => _overlapHeaders
      ? _contentBox.getMaxIntrinsicHeight(width)
      : (_headerBox.getMaxIntrinsicHeight(width) +
          _contentBox.getMaxIntrinsicHeight(width));

  @override
  double? computeDistanceToActualBaseline(final TextBaseline baseline) =>
      defaultComputeDistanceToHighestActualBaseline(baseline);

  @override
  bool hitTestChildren(
    final HitTestResult result, {
    required final Offset position,
  }) =>
      defaultHitTestChildren(
        result as BoxHitTestResult,
        position: position,
      );

  @override
  bool get isRepaintBoundary => true;

  @override
  void paint(final PaintingContext context, final Offset offset) {
    defaultPaint(context, offset);
  }
}
