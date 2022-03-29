#import "SensorPlugin.h"
#if __has_include(<sensor_plugin/sensor_plugin-Swift.h>)
#import <sensor_plugin/sensor_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "sensor_plugin-Swift.h"
#endif

@implementation SensorPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSensorPlugin registerWithRegistrar:registrar];
}
@end
