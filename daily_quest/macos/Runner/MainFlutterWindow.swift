import Cocoa
import FlutterMacOS
import IOKit.ps
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

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
    guard let clientID = FirebaseApp.app()?.options.clientID else { return }

    // Create Google Sign In configuration object.
    let config = GIDConfiguration(clientID: clientID)
    GIDSignIn.sharedInstance.configuration = config

    // Start the sign in flow!
    GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
        guard error == nil else {
            return
        }

        guard let user = result?.user,
          let idToken = user.idToken?.tokenString
        else {
            return 
        }

        let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                       accessToken: user.accessToken.tokenString)
        // ...
      }
  }
}
