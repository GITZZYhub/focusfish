#import "VibratePlugin.h"
#if __has_include(<vibrate_plugin/vibrate_plugin-Swift.h>)
#import <vibrate_plugin/vibrate_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "vibrate_plugin-Swift.h"
#endif

@implementation VibratePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftVibratePlugin registerWithRegistrar:registrar];
}
@end
