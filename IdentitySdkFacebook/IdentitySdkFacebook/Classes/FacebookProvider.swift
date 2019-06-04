import Foundation
import IdentitySdkCore

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
}
