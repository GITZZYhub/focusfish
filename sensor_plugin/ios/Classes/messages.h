// Autogenerated from Pigeon (v2.0.2), do not edit directly.
// See also: https://pub.dev/packages/pigeon
#import <Foundation/Foundation.h>
@protocol FlutterBinaryMessenger;
@protocol FlutterMessageCodec;
@class FlutterError;
@class FlutterStandardTypedData;

NS_ASSUME_NONNULL_BEGIN


/// The codec used by FLTHostSensorPluginApi.
NSObject<FlutterMessageCodec> *FLTHostSensorPluginApiGetCodec(void);

@protocol FLTHostSensorPluginApi
/// @return `nil` only when `error != nil`.
- (nullable NSNumber *)isSensorAvailableWithError:(FlutterError *_Nullable *_Nonnull)error;
@end

extern void FLTHostSensorPluginApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<FLTHostSensorPluginApi> *_Nullable api);

NS_ASSUME_NONNULL_END
