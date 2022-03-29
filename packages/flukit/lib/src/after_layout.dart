import 'package:flutter/widgets.dart';

typedef AfterLayoutCallback = void Function(BuildContext context);

/// Sometimes we need to do something after the build phase is
/// complete, for example, most of [BuildContext] methods and attributes,
/// such as
/// `context.findRenderObject()`、`context.size` only can be used after build.
///
/// Does *not* request a new frame in [AfterLayout.callback], that is to say
/// you mustn't call `setState()` in [AfterLayout.callback] which will lead to
/// circular call.
///

class AfterLayout extends StatelessWidget {
  const AfterLayout({
    final Key? key,
    required final this.callback,
    required final this.child,
  }) : super(key: key);

  ///when the main rendering pipeline has been flushed
  /// (we can consider layout phase is complete), the
  /// [callback] will be called.
  final AfterLayoutCallback callback;
  final Widget child;

  @override
  Widget build(final BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((final _) {
      callback(context);
    });
    return child;
  }
}
