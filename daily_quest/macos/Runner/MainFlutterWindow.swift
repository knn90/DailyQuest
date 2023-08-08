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
          self?.googleSignIn(completion: { signInResult in
              result(signInResult)
          })
          return
        default:
          result(FlutterMethodNotImplemented)
       }
    }
  }

    private func googleSignIn(completion: @escaping (Bool) -> Void) {
    print("Signin with Google on MacOS")
    guard let clientID = FirebaseApp.app()?.options.clientID else {
        fatalError("Missing ClientID")
    }

    let config = GIDConfiguration(clientID: clientID)
    GIDSignIn.sharedInstance.configuration = config

    GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
        guard error == nil else {
            completion(false)
            return
        }

        guard let user = result?.user,
          let idToken = user.idToken?.tokenString
        else {
            completion(false)
            return
        }

        let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                       accessToken: user.accessToken.tokenString)
        Auth.auth().signIn(with: credential) { authResult, authError in
            guard authError == nil else {
                completion(false)
                return
            }
            completion(true)
        }
      }
  }
}
