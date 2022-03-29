import 'package:pigeon/pigeon.dart';

enum FeedbackType {
  success,
  error,
  warning,
  selection,
  impact,
  heavy,
  medium,
  light
}

class FeedbackTypeClass {
  FeedbackType? type;
}

/// invoked by Dart and are received by a host-platform
@HostApi()
abstract class HostVibratePluginApi {
  void vibrate(int duration);
  bool canVibrate();
  void feedback(FeedbackTypeClass feedbackType);
}
