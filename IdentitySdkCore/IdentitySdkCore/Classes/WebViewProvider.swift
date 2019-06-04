import Foundation

public class WebViewProvider: ProviderCreator {
    public static let NAME = "webview"
    
    public var name: String = NAME
    
    public init() {}
    
    public func create(sdkConfig: SdkConfig) -> Provider {
        return ConfiguredWebViewProvider()
    }
}

class ConfiguredWebViewProvider: NSObject, Provider {
    var name: String = WebViewProvider.NAME
    
    override var description: String {
        return "Provider: \(name)"
    }
}
