// Autogenerated from Pigeon (v2.0.2), do not edit directly.
// See also: https://pub.dev/packages/pigeon
#import "messages.h"
#import <Flutter/Flutter.h>

#if !__has_feature(objc_arc)
#error File requires ARC to be enabled.
#endif

static NSDictionary<NSString *, id> *wrapResult(id result, FlutterError *error) {
  NSDictionary *errorDict = (NSDictionary *)[NSNull null];
  if (error) {
    errorDict = @{
        @"code": (error.code ? error.code : [NSNull null]),
        @"message": (error.message ? error.message : [NSNull null]),
        @"details": (error.details ? error.details : [NSNull null]),
        };
  }
  return @{
      @"result": (result ? result : [NSNull null]),
      @"error": errorDict,
      };
}
static id GetNullableObject(NSDictionary* dict, id key) {
  id result = dict[key];
  return (result == [NSNull null]) ? nil : result;
}
static id GetNullableObjectAtIndex(NSArray* array, NSInteger key) {
  id result = array[key];
  return (result == [NSNull null]) ? nil : result;
}



@interface FLTHostSensorPluginApiCodecReader : FlutterStandardReader
@end
@implementation FLTHostSensorPluginApiCodecReader
@end

@interface FLTHostSensorPluginApiCodecWriter : FlutterStandardWriter
@end
@implementation FLTHostSensorPluginApiCodecWriter
@end

@interface FLTHostSensorPluginApiCodecReaderWriter : FlutterStandardReaderWriter
@end
@implementation FLTHostSensorPluginApiCodecReaderWriter
- (FlutterStandardWriter *)writerWithData:(NSMutableData *)data {
  return [[FLTHostSensorPluginApiCodecWriter alloc] initWithData:data];
}
- (FlutterStandardReader *)readerWithData:(NSData *)data {
  return [[FLTHostSensorPluginApiCodecReader alloc] initWithData:data];
}
@end

NSObject<FlutterMessageCodec> *FLTHostSensorPluginApiGetCodec() {
  static dispatch_once_t sPred = 0;
  static FlutterStandardMessageCodec *sSharedObject = nil;
  dispatch_once(&sPred, ^{
    FLTHostSensorPluginApiCodecReaderWriter *readerWriter = [[FLTHostSensorPluginApiCodecReaderWriter alloc] init];
    sSharedObject = [FlutterStandardMessageCodec codecWithReaderWriter:readerWriter];
  });
  return sSharedObject;
}


void FLTHostSensorPluginApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<FLTHostSensorPluginApi> *api) {
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.HostSensorPluginApi.isSensorAvailable"
        binaryMessenger:binaryMessenger
        codec:FLTHostSensorPluginApiGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(isSensorAvailableWithError:)], @"FLTHostSensorPluginApi api (%@) doesn't respond to @selector(isSensorAvailableWithError:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        FlutterError *error;
        NSNumber *output = [api isSensorAvailableWithError:&error];
        callback(wrapResult(output, error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
}
