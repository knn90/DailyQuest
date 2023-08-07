import Cocoa
import FlutterMacOS
import IOKit.ps

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)

    RegisterGeneratedPlugins(registry: flutterViewController)
    registerAuthenticationChannel(registry: flutterViewController)
    super.awakeFromNib()
  }

  private func registerAuthenticationChannel(registry: FlutterViewController) {
    let authenticationChannel = FlutterMethodChannel(
      name: "com.dailyquest/authentication",
      binaryMessenger: registry.engine.binaryMessenger)
    authenticationChannel.setMethodCallHandler { [weak self] (call, result) in
      switch call.method {
        case "googleSignIn":
          self?.googleSignIn() 
          return
        default:
          result(FlutterMethodNotImplemented)
       }
    }

    RegisterGeneratedPlugins(registry: registry)
  }

  private func googleSignIn() {
    print("Signin with Google on MacOS")
  }
}
