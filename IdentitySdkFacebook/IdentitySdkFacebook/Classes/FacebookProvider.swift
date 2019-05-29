import Foundation
import IdentitySdkCore

public class FacebookProvider: ProviderCreator {
    public func create(sdkConfig: SdkConfig) -> Provider {
        return ConfiguredFacebookProvider()
    }
}

public class ConfiguredFacebookProvider: Provider {
    public func helloWorld() -> String {
        return "hello from ConfiguredFacebookProvider"
    }
}
