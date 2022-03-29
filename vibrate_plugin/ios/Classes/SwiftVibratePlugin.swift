import Flutter
import UIKit
import AudioToolbox

public class SwiftVibratePlugin: NSObject, FlutterPlugin, FLTHostVibratePluginApi {
    private let isDevice = TARGET_OS_SIMULATOR == 0

    public static func register(with registrar: FlutterPluginRegistrar) {
        let messenger : FlutterBinaryMessenger = registrar.messenger()
        let api = SwiftVibratePlugin.init()
        FLTHostVibratePluginApiSetup(messenger, api);
    }

    public func vibrateDuration(_ duration: NSNumber, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }

    public func canVibrateWithError(_ error: AutoreleasingUnsafeMutablePointer<FlutterError?>) -> NSNumber? {
        return NSNumber(value: isDevice)
    }

    public func feedbackFeedbackType(_ feedbackType: FLTFeedbackTypeClass, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        switch (feedbackType.type) {
        case .impact:
            if #available(iOS 10.0, *) {
                let impact = UIImpactFeedbackGenerator()
                impact.prepare()
                impact.impactOccurred()
            } else {
                // Fallback on earlier versions
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            }
        case .success:
            if #available(iOS 10.0, *) {
                let notification = UINotificationFeedbackGenerator()
                notification.prepare()
                notification.notificationOccurred(.success)
            } else {
                // Fallback on earlier versions
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            }
        case .error:
            if #available(iOS 10.0, *) {
                let notification = UINotificationFeedbackGenerator()
                notification.prepare()
                notification.notificationOccurred(.error)
            } else {
                // Fallback on earlier versions
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            }
        case .warning:
            if #available(iOS 10.0, *) {
                let notification = UINotificationFeedbackGenerator()
                notification.prepare()
                notification.notificationOccurred(.warning)
            } else {
                // Fallback on earlier versions
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            }
        case .selection:
            if #available(iOS 10.0, *) {
                let selection = UISelectionFeedbackGenerator()
                selection.prepare()
                selection.selectionChanged()
            } else {
                // Fallback on earlier versions
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            }
        case .heavy:
            if #available(iOS 10.0, *) {
                let generator = UIImpactFeedbackGenerator(style: .heavy)
                generator.prepare()
                generator.impactOccurred()
            } else {
                // Fallback on earlier versions
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            }
        case .medium:
            if #available(iOS 10.0, *) {
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.prepare()
                generator.impactOccurred()
            } else {
                // Fallback on earlier versions
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            }
        case .light:
            if #available(iOS 10.0, *) {
                let generator = UIImpactFeedbackGenerator(style: .light)
                generator.prepare()
                generator.impactOccurred()
            } else {
                // Fallback on earlier versions
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            }
        @unknown default:
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        }
    }
}
