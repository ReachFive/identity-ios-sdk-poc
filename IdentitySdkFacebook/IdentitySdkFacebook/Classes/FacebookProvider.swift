import Foundation
import IdentitySdkCore

public class FacebookProvider: ProviderCreator {
    public func create(sdkConfig: SdkConfig) -> Provider {
        return ConfiguredFacebookProvider()
    }
}

class ConfiguredFacebookProvider: Provider {
    func helloWorld() -> String {
        return "hello from ConfiguredFacebookProvider"
    }
}
