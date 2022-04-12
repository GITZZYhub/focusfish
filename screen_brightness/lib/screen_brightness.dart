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

  static Future<void> setScreenBrightness(double brightness) async =>
      _api.setScreenBrightness(brightness);

  static Future<void> resetScreenBrightness() async =>
      _api.resetScreenBrightness();

  static Future<bool> get hasChanged async => _api.hasChanged();

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
