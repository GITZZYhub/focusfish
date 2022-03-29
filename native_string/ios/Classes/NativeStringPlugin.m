#import "NativeStringPlugin.h"
#if __has_include(<native_string/native_string-Swift.h>)
#import <native_string/native_string-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "native_string-Swift.h"
#endif

@implementation NativeStringPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftNativeStringPlugin registerWithRegistrar:registrar];
}
@end
