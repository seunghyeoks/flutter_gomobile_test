import Flutter
import Samplefunc

public class SamplefuncPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "samplefunc", binaryMessenger: registrar.messenger())
    let instance = SamplefuncPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "sum":
      if let args = call.arguments as? [String: Any],
         let a = args["a"] as? Int,
         let b = args["b"] as? Int {
          let sum = SamplefuncSum(Int(a), Int(b))
        result(Int(sum))
      } else {
        result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments for sum", details: nil))
      }
    case "readFileContent":
      if let args = call.arguments as? [String: Any],
         let filePath = args["filePath"] as? String {
        let content = SamplefuncReadFileContent(filePath)
        result(content)
      } else {
        result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments for readFileContent", details: nil))
      }
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
