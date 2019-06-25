import Foundation
import UIKit
import IdentitySdkCore
import FacebookCore
import FacebookLogin
import FBSDKLoginKit

public class FacebookProvider: ProviderCreator {
    public static var NAME: String = "facebook"
    
    public var name: String = NAME
    
    public init() {}

    public func create(sdkConfig: SdkConfig) -> Provider {
        return ConfiguredFacebookProvider()
    }
}

public class ConfiguredFacebookProvider: NSObject, Provider {
    public var name: String = FacebookProvider.NAME
    
    public override init() {}
    
    public override var description: String {
        return "Provider: \(name)"
    }
    
    public func login(origin: String, viewController: UIViewController?) {
        print("ConfiguredFacebookProvider.login")
        let loginManager = LoginManager()
        loginManager.logIn(permissions: [.email, .publicProfile], viewController: viewController) { result in
            switch (result) {
            case .success(let granted, let declined, let token):
                print("----- ------ ConfiguredFacebookProvider.login success granted=\(granted) declined=\(declined) token=\(token)")
            case .cancelled:
                print("----- ------ ConfiguredFacebookProvider.login cancelled")
            case .failed(let error):
                print("----- ------ ConfiguredFacebookProvider.login error \(error)")
                
            }
        }
    }
    
    public func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKCoreKit.ApplicationDelegate.shared.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    public func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        return FBSDKCoreKit.ApplicationDelegate.shared.application(app, open: url, options: options)
    }
    
    public func applicationDidBecomeActive(_ application: UIApplication) {
        AppEvents.activateApp()
    }
}
