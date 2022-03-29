
import 'dart:async';

import 'package:flutter/services.dart';

import 'messages.dart';

class SensorPlugin {
  static HostSensorPluginApi? _apiInstance;

  static HostSensorPluginApi get _api => _apiInstance ??= HostSensorPluginApi();

  static Future<bool> get isSensorAvailable async => _api.isSensorAvailable();

  static const EventChannel _eventChannel =
  EventChannel('com.bwjh.sensor_plugin');

  static Stream<dynamic> stream() => _eventChannel.receiveBroadcastStream();
}
