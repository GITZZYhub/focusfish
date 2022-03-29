import Flutter
import UIKit
import CoreMotion

public class SwiftSensorPlugin: NSObject, FlutterPlugin, FLTHostSensorPluginApi, FlutterStreamHandler {

    let motionManager = CMMotionManager()

    public static func register(with registrar: FlutterPluginRegistrar) {
        let messenger : FlutterBinaryMessenger = registrar.messenger()
        let eventChannel = FlutterEventChannel(name: "com.bwjh.sensor_plugin", binaryMessenger: messenger)
        eventChannel.setStreamHandler(SwiftSensorPlugin())

        let api = SwiftSensorPlugin.init()
        FLTHostSensorPluginApiSetup(messenger, api);
    }

    public func isSensorAvailableWithError(_ error: AutoreleasingUnsafeMutablePointer<FlutterError?>) -> NSNumber? {
        return NSNumber(value: motionManager.isDeviceMotionAvailable)
    }

    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        motionManager.startDeviceMotionUpdates(to: .main) { (motion, error) in

            let gravityX = motion?.gravity.x ?? 0
            let gravityY = motion?.gravity.y ?? 0
            let gravityZ = motion?.gravity.z ?? 0

            let zTheta = atan2(gravityZ, sqrt(gravityX * gravityX + gravityY * gravityY)) / Double.pi * 180.0
            let xyTheta = abs(abs(atan2(gravityX, gravityY) / Double.pi * 180.0) - 180)
            let XAng = zTheta.isNaN ? 0 : zTheta;
            let YAng = gravityX > 0 ? xyTheta: -xyTheta;
            let json = "{\"X\": \(Double(round(XAng*10))/10), \"Y\": \(Double(round(YAng*10))/10)}"
            events(json)
        }
        return nil
    }

    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        motionManager.stopDeviceMotionUpdates()
        return nil
    }
}
