import 'dart:async';

import 'package:flutter/services.dart';

import 'messages.dart';

class ScreenBrightness {
  static HostScreenBrightnessApi? _apiInstance;

  static HostScreenBrightnessApi get _api =>
      _apiInstance ??= HostScreenBrightnessApi();

  static Future<double> get systemBrightness async =>
      _api.getSystemBrightness();

  static Future<double> get currentBrightness async =>
      _api.getCurrentBrightness();

  static Future<void> setScreenBrightness(double brightness) async {
    _api.setScreenBrightness(brightness);
  }

  static Future<void> setScreenBrightnessDelay(
      double brightness, int milliseconds) async {
    final systemBrightness = await _api.getSystemBrightness();
    final diff = (systemBrightness - brightness) / 10;
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (timer.tick > milliseconds / 100) {
        _api.setScreenBrightness(brightness);
        timer.cancel();
        return;
      }
      _api.setScreenBrightness(systemBrightness - diff * timer.tick);
    });
  }

  static Future<void> resetScreenBrightness() async =>
      _api.resetScreenBrightness();

  static Future<bool> get hasChanged async => _api.hasChanged();

  static Future<bool> get isScreenLocked async => _api.isScreenLocked();

  static const EventChannel _eventChannel =
      EventChannel('com.bwjh.screen_brightness');

  /// Returns stream with screen brightness changes including
  /// [ScreenBrightness.setScreenBrightness],
  /// [ScreenBrightness.resetScreenBrightness], system control center or system
  /// setting.
  ///
  /// This stream is useful for user to listen to brightness changes.
  static Stream<dynamic> onCurrentBrightnessChanged() =>
      _eventChannel.receiveBroadcastStream();
}
