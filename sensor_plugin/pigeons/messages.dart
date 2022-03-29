import 'package:pigeon/pigeon.dart';

/// invoked by Dart and are received by a host-platform
@HostApi()
// ignore: one_member_abstracts
abstract class HostSensorPluginApi {
  bool isSensorAvailable();
}
