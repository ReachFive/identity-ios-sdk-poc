import Foundation

public class WebViewProvider: ProviderCreator {
    public func loginWithProvider(name: String, origin: String) {
        
    }
    
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

    public func login(origin: String, viewController: UIViewController?) {
        
    }

    public func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return true
    }

    public func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        return true
    }
    
    public func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
}
