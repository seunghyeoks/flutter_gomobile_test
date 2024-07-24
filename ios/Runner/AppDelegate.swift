import Flutter
import UIKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    SamplefuncPlugin.register(with: self.registrar(forPlugin: "SamplefuncPlugin")!)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
