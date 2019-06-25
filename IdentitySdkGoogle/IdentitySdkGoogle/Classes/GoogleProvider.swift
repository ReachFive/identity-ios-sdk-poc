import Foundation
import UIKit
import IdentitySdkCore
import GoogleSignIn

public class GoogleProvider: ProviderCreator {
    public static var NAME: String = "google"
    
    public var name: String = NAME
    
    public init() {}
    
    public func create(sdkConfig: SdkConfig) -> Provider {
        return ConfiguredGoogleProvider(sdkConfig: sdkConfig)
    }
}


public class ConfiguredGoogleProvider: NSObject, Provider, GIDSignInDelegate, GIDSignInUIDelegate {
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        print("ConfiguredGoogleProvider.sign.error=\(error.debugDescription)")
    }
    
    public func login(origin: String, viewController: UIViewController?) {
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = viewController as! GIDSignInUIDelegate
        GIDSignIn.sharedInstance().signIn()
    }
    
    public func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        return GIDSignIn.sharedInstance().handle(
            url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
    }
    
    public func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        var _: [String: AnyObject] = [UIApplication.OpenURLOptionsKey.sourceApplication.rawValue: sourceApplication as AnyObject,
                                            UIApplication.OpenURLOptionsKey.annotation.rawValue: annotation as AnyObject]
        return GIDSignIn.sharedInstance().handle(url,
                                                    sourceApplication: sourceApplication,
                                                    annotation: annotation)

    }
    
    public func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    public var name: String = GoogleProvider.NAME
    
    public init(sdkConfig: SdkConfig) {
        GIDSignIn.sharedInstance().clientID = sdkConfig.clientId
    }
    
    public override var description: String {
        return "Provider: \(name)"
    }
}
