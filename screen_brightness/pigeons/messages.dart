import 'package:pigeon/pigeon.dart';

/// invoked by Dart and are received by a host-platform
@HostApi()
abstract class HostScreenBrightnessApi {

  /// Returns system screen brightness which is set when application is started.
  ///
  /// The value should be within 0.0 - 1.0. Otherwise, [RangeError.range] will
  /// be throw.
  ///
  /// This parameter is useful for user to get screen brightness value after
  /// calling [resetScreenBrightness]
  double getSystemBrightness();

  /// Returns current screen brightness which is current screen brightness value.
  ///
  /// The value should be within 0.0 - 1.0. Otherwise, [RangeError.range] will
  /// be throw.
  ///
  /// This parameter is useful for user to get screen brightness value after
  /// calling [setScreenBrightness]
  double getCurrentBrightness();

  /// Set screen brightness with double value.
  ///
  /// The value should be within 0.0 - 1.0. Otherwise, [RangeError.range] will
  /// be throw.
  ///
  /// This method is useful for user to change screen brightness.
  void setScreenBrightness(double brightness);

  /// Reset screen brightness with (Android)-1 or (iOS)system brightness value.
  ///
  /// This method is useful for user to reset screen brightness when user leave
  /// the page which has change the brightness value.
  void resetScreenBrightness();

  /// Returns boolean to identify brightness has changed with this plugin.
  ///
  /// e.g
  /// [ScreenBrightness.setScreenBrightness] will make this true
  /// [ScreenBrightness.resetScreenBrightness] will make this false
  bool hasChanged();
}
