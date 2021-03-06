// Autogenerated from Pigeon (v2.0.3), do not edit directly.
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



@interface FLTHostScreenBrightnessApiCodecReader : FlutterStandardReader
@end
@implementation FLTHostScreenBrightnessApiCodecReader
@end

@interface FLTHostScreenBrightnessApiCodecWriter : FlutterStandardWriter
@end
@implementation FLTHostScreenBrightnessApiCodecWriter
@end

@interface FLTHostScreenBrightnessApiCodecReaderWriter : FlutterStandardReaderWriter
@end
@implementation FLTHostScreenBrightnessApiCodecReaderWriter
- (FlutterStandardWriter *)writerWithData:(NSMutableData *)data {
  return [[FLTHostScreenBrightnessApiCodecWriter alloc] initWithData:data];
}
- (FlutterStandardReader *)readerWithData:(NSData *)data {
  return [[FLTHostScreenBrightnessApiCodecReader alloc] initWithData:data];
}
@end

NSObject<FlutterMessageCodec> *FLTHostScreenBrightnessApiGetCodec() {
  static dispatch_once_t sPred = 0;
  static FlutterStandardMessageCodec *sSharedObject = nil;
  dispatch_once(&sPred, ^{
    FLTHostScreenBrightnessApiCodecReaderWriter *readerWriter = [[FLTHostScreenBrightnessApiCodecReaderWriter alloc] init];
    sSharedObject = [FlutterStandardMessageCodec codecWithReaderWriter:readerWriter];
  });
  return sSharedObject;
}


void FLTHostScreenBrightnessApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<FLTHostScreenBrightnessApi> *api) {
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.HostScreenBrightnessApi.getSystemBrightness"
        binaryMessenger:binaryMessenger
        codec:FLTHostScreenBrightnessApiGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(getSystemBrightnessWithError:)], @"FLTHostScreenBrightnessApi api (%@) doesn't respond to @selector(getSystemBrightnessWithError:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        FlutterError *error;
        NSNumber *output = [api getSystemBrightnessWithError:&error];
        callback(wrapResult(output, error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.HostScreenBrightnessApi.getCurrentBrightness"
        binaryMessenger:binaryMessenger
        codec:FLTHostScreenBrightnessApiGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(getCurrentBrightnessWithError:)], @"FLTHostScreenBrightnessApi api (%@) doesn't respond to @selector(getCurrentBrightnessWithError:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        FlutterError *error;
        NSNumber *output = [api getCurrentBrightnessWithError:&error];
        callback(wrapResult(output, error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.HostScreenBrightnessApi.setScreenBrightness"
        binaryMessenger:binaryMessenger
        codec:FLTHostScreenBrightnessApiGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(setScreenBrightnessBrightness:error:)], @"FLTHostScreenBrightnessApi api (%@) doesn't respond to @selector(setScreenBrightnessBrightness:error:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSNumber *arg_brightness = GetNullableObjectAtIndex(args, 0);
        FlutterError *error;
        [api setScreenBrightnessBrightness:arg_brightness error:&error];
        callback(wrapResult(nil, error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.HostScreenBrightnessApi.resetScreenBrightness"
        binaryMessenger:binaryMessenger
        codec:FLTHostScreenBrightnessApiGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(resetScreenBrightnessWithError:)], @"FLTHostScreenBrightnessApi api (%@) doesn't respond to @selector(resetScreenBrightnessWithError:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        FlutterError *error;
        [api resetScreenBrightnessWithError:&error];
        callback(wrapResult(nil, error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.HostScreenBrightnessApi.hasChanged"
        binaryMessenger:binaryMessenger
        codec:FLTHostScreenBrightnessApiGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(hasChangedWithError:)], @"FLTHostScreenBrightnessApi api (%@) doesn't respond to @selector(hasChangedWithError:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        FlutterError *error;
        NSNumber *output = [api hasChangedWithError:&error];
        callback(wrapResult(output, error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.HostScreenBrightnessApi.isScreenLocked"
        binaryMessenger:binaryMessenger
        codec:FLTHostScreenBrightnessApiGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(isScreenLockedWithError:)], @"FLTHostScreenBrightnessApi api (%@) doesn't respond to @selector(isScreenLockedWithError:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        FlutterError *error;
        NSNumber *output = [api isScreenLockedWithError:&error];
        callback(wrapResult(output, error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
}
