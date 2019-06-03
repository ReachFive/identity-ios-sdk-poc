import Foundation

public class WebViewProvider: ProviderCreator {
    public init() {}
    public func create(sdkConfig: SdkConfig) -> Provider {
        return ConfiguredWebViewProvider()
    }
}

class ConfiguredWebViewProvider: Provider {
    public func helloWorld() -> String {
        return "Hello from sdk core: WebViewProvider 2"
    }
}
