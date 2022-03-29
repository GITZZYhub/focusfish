// Copyright 2019 The Fuchsia Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/widgets.dart';

/// Widget whose [Element] calls a callback when the element is mounted.
class PostMountCallback extends StatelessWidget {
  /// Creates a [PostMountCallback] widget.
  const PostMountCallback({
    required final this.child,
    final this.callback,
    final Key? key,
  }) : super(key: key);

  /// The widget below this widget in the tree.
  final Widget child;

  /// Callback to call when the element for this widget is mounted.
  final void Function()? callback;

  @override
  StatelessElement createElement() => _PostMountCallbackElement(this);

  @override
  Widget build(final BuildContext context) => child;
}

class _PostMountCallbackElement extends StatelessElement {
  _PostMountCallbackElement(final PostMountCallback widget) : super(widget);

  @override
  void mount(final Element? parent, final Object? newSlot) {
    super.mount(parent, newSlot);
    final postMountCallback = widget as PostMountCallback;
    postMountCallback.callback?.call();
  }
}
