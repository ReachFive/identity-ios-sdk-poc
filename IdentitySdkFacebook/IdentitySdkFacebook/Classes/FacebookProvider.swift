import Foundation
import UIKit
import IdentitySdkCore
import FBSDKCoreKit
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
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
}
