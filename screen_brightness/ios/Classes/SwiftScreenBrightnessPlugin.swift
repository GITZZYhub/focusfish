import Flutter
import UIKit

public class SwiftScreenBrightnessPlugin: NSObject, FlutterPlugin, FlutterApplicationLifeCycleDelegate, FLTHostScreenBrightnessApi {
    
    var methodChannel: FlutterMethodChannel?
    
    var currentBrightnessChangeEventChannel: FlutterEventChannel?
    let currentBrightnessChangeStreamHandler: CurrentBrightnessChangeStreamHandler = CurrentBrightnessChangeStreamHandler()
    
    var systemBrightness: CGFloat?
    var changedBrightness: CGFloat?
    
    var isAutoReset: Bool = true
    
    let taskQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        
        let messenger : FlutterBinaryMessenger = registrar.messenger()
        let eventChannel = FlutterEventChannel(name: "com.bwjh.screen_brightness", binaryMessenger: messenger)
        
        let api = SwiftScreenBrightnessPlugin.init()
        eventChannel.setStreamHandler(api.currentBrightnessChangeStreamHandler)
        FLTHostScreenBrightnessApiSetup(messenger, api)
    }
    
    override init() {
        super.init()
        systemBrightness = UIScreen.main.brightness
    }
    
    public func getSystemBrightnessWithError(_ error: AutoreleasingUnsafeMutablePointer<FlutterError?>) -> NSNumber? {
        return systemBrightness as NSNumber?
    }
    
    public func getCurrentBrightnessWithError(_ error: AutoreleasingUnsafeMutablePointer<FlutterError?>) -> NSNumber? {
        return UIScreen.main.brightness as NSNumber
    }
    
    public func setScreenBrightnessBrightness(_ brightness: NSNumber, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        
        let _changedBrightness = CGFloat(brightness.doubleValue)
        setScreenBrightness(brightness: _changedBrightness)
        
        changedBrightness = _changedBrightness
        handleCurrentBrightnessChanged(_changedBrightness)
    }
    
    private func handleCurrentBrightnessChanged(_ currentBrightness: CGFloat) {
        currentBrightnessChangeStreamHandler.addCurrentBrightnessToEventSink(currentBrightness)
    }
    
    private func setScreenBrightness(brightness: CGFloat) {
        taskQueue.cancelAllOperations()
        let step: CGFloat = 0.04 * ((brightness > UIScreen.main.brightness) ? 1 : -1)
        taskQueue.addOperations(stride(from: UIScreen.main.brightness, through: brightness, by: step).map({ _brightness -> Operation in
            let blockOperation = BlockOperation()
            unowned let _unownedOperation = blockOperation
            blockOperation.addExecutionBlock({
                if !_unownedOperation.isCancelled {
                    Thread.sleep(forTimeInterval: 1 / 60.0)
                    DispatchQueue.main.async {
                        UIScreen.main.brightness = _brightness
                    }
                }
            })
            return blockOperation
        }), waitUntilFinished: true)
    }
    
    public func resetScreenBrightnessWithError(_ error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        guard let initialBrightness = systemBrightness else {
            //                    result(FlutterError.init(code: "-2", message: "Unexpected error on null brightness", details: nil))
            return
        }
        
        setScreenBrightness(brightness: initialBrightness)
        
        changedBrightness = nil
        handleCurrentBrightnessChanged(initialBrightness)
    }
    
    public func hasChangedWithError(_ error: AutoreleasingUnsafeMutablePointer<FlutterError?>) -> NSNumber? {
        return NSNumber(value: changedBrightness != nil)
    }
    
    @objc private func onSystemBrightnessChanged(notification: Notification) {
        guard let screenObject = notification.object, let brightness = (screenObject as AnyObject).brightness else {
            return
        }
        
        systemBrightness = brightness
        if (changedBrightness == nil) {
            handleCurrentBrightnessChanged(brightness)
        }
    }
    
    func onApplicationPause() {
        guard let initialBrightness = systemBrightness else {
            return
        }
        
        setScreenBrightness(brightness: initialBrightness)
    }
    
    func onApplicationResume() {
        guard let changedBrightness = changedBrightness else {
            return
        }
        
        setScreenBrightness(brightness: changedBrightness)
    }
    
    public func applicationWillResignActive(_ application: UIApplication) {
        guard isAutoReset else {
            return
        }
        
        onApplicationPause()
        NotificationCenter.default.addObserver(self, selector: #selector(onSystemBrightnessChanged), name: UIScreen.brightnessDidChangeNotification, object: nil)
    }
    
    public func applicationDidBecomeActive(_ application: UIApplication) {
        guard isAutoReset else {
            return
        }
        
        NotificationCenter.default.removeObserver(self, name: UIScreen.brightnessDidChangeNotification, object: nil)
        systemBrightness = UIScreen.main.brightness
        if (changedBrightness == nil) {
            handleCurrentBrightnessChanged(systemBrightness!)
        }
        
        onApplicationResume()
    }
    
    public func applicationWillTerminate(_ application: UIApplication) {
        onApplicationPause()
        NotificationCenter.default.removeObserver(self)
    }
    
    public func detachFromEngine(for registrar: FlutterPluginRegistrar) {
        NotificationCenter.default.removeObserver(self)
        
        methodChannel?.setMethodCallHandler(nil)
        currentBrightnessChangeEventChannel?.setStreamHandler(nil)
    }
}
