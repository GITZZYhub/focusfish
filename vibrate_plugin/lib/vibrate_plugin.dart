import 'dart:async';

import 'messages.dart';

class VibratePlugin {
  static const Duration _defaultVibrationDuration = Duration(milliseconds: 500);

  static HostVibratePluginApi? _apiInstance;

  static HostVibratePluginApi get _api =>
      _apiInstance ??= HostVibratePluginApi();

  static Future<bool> get canVibrate async => _api.canVibrate();

  static Future<void> vibrate() async =>
      _api.vibrate(_defaultVibrationDuration.inMilliseconds);

  static void feedback(final FeedbackType type) {
    _api.feedback(FeedbackTypeClass()..type = type);
  }

  /// Vibrates with [pauses] in between each vibration
  /// Will always vibrate once before the first pause
  /// and once after the last pause

  static Future<void> vibrateWithPauses(final List<Duration> pauses) async {
    for (final d in pauses) {
      vibrate();
      //Because the native vibration is not awaited, we need to wait for
      //the vibration to end before launching another one
      await Future.delayed(_defaultVibrationDuration, () => {});
      await Future.delayed(d, () => {});
    }
    vibrate();
  }
}
