// Copyright 2019 The Fuchsia Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/widgets.dart';

/// A registry to track some [Element]s in the tree.
class RegistryWidget extends StatefulWidget {
  /// Creates a [RegistryWidget].
  const RegistryWidget({
    final Key? key,
    final this.elementNotifier,
    required final this.child,
  }) : super(key: key);

  /// The widget below this widget in the tree.
  final Widget child;

  /// Contains the current set of all [Element]s created by
  /// [RegisteredElementWidget]s in the tree below this widget.
  ///
  /// Note that if there is another [RegistryWidget] in this widget's subtree
  /// that registry, and not this one, will collect elements in its subtree.
  final ValueNotifier<Set<Element>?>? elementNotifier;

  @override
  State<StatefulWidget> createState() => _RegistryWidgetState();
}

/// A widget whose [Element] will be added its nearest ancestor
/// [RegistryWidget].
class RegisteredElementWidget extends ProxyWidget {
  /// Creates a [RegisteredElementWidget].
  const RegisteredElementWidget({final Key? key, required final Widget child})
      : super(key: key, child: child);

  @override
  Element createElement() => _RegisteredElement(this);
}

class _RegistryWidgetState extends State<RegistryWidget> {
  final Set<Element> registeredElements = {};

  @override
  Widget build(final BuildContext context) => _InheritedRegistryWidget(
        state: this,
        child: widget.child,
      );
}

class _InheritedRegistryWidget extends InheritedWidget {
  final _RegistryWidgetState state;

  const _InheritedRegistryWidget({
    final Key? key,
    required final this.state,
    required final Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(final InheritedWidget oldWidget) => true;
}

class _RegisteredElement extends ProxyElement {
  _RegisteredElement(final ProxyWidget widget) : super(widget);

  @override
  void notifyClients(final ProxyWidget oldWidget) {}

  late _RegistryWidgetState _registryWidgetState;

  @override
  void mount(final Element? parent, final Object? newSlot) {
    super.mount(parent, newSlot);
    final _inheritedRegistryWidget =
        dependOnInheritedWidgetOfExactType<_InheritedRegistryWidget>()!;
    _registryWidgetState = _inheritedRegistryWidget.state;
    _registryWidgetState.registeredElements.add(this);
    _registryWidgetState.widget.elementNotifier?.value =
        _registryWidgetState.registeredElements;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final _inheritedRegistryWidget =
        dependOnInheritedWidgetOfExactType<_InheritedRegistryWidget>()!;
    _registryWidgetState = _inheritedRegistryWidget.state;
    _registryWidgetState.registeredElements.add(this);
    _registryWidgetState.widget.elementNotifier?.value =
        _registryWidgetState.registeredElements;
  }

  @override
  void unmount() {
    _registryWidgetState.registeredElements.remove(this);
    _registryWidgetState.widget.elementNotifier?.value =
        _registryWidgetState.registeredElements;
    super.unmount();
  }
}
