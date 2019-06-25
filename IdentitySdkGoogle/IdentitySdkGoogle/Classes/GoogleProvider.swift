import Foundation
import IdentitySdkCore
import GoogleSignIn

public class GoogleProvider: ProviderCreator {
    public static var NAME: String = "google"
    
    public var name: String = NAME
    
    public init() {}
    
    public func create(sdkConfig: SdkConfig) -> Provider {
        return ConfiguredGoogleProvider()
    }
}


public class ConfiguredGoogleProvider: NSObject, Provider {
    public func login(origin: String, viewController: UIViewController?) {
        
    }
    
    public func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        return true
    }
    
    public func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return true
    }
    
    public func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    public var name: String = GoogleProvider.NAME
    
    public override init() {}
    
    public override var description: String {
        return "Provider: \(name)"
    }
}
