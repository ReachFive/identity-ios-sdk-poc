import Foundation
import IdentitySdkCore

public class WebViewProvider: ProviderCreator {
    public func loginWithProvider(name: String, origin: String) {
        
    }
    
    public static let NAME = "webview"
    
    public var name: String = NAME
    
    public init() {}
    
    public func create(sdkConfig: SdkConfig, providerConfig: ProviderConfig) -> Provider {
        return ConfiguredWebViewProvider(sdkConfig: sdkConfig, providerConfig: providerConfig)
    }
}

class ConfiguredWebViewProvider: NSObject, Provider {
    var sdkConfig: SdkConfig
    var providerConfig: ProviderConfig
    var name: String = WebViewProvider.NAME
    
    override var description: String {
        return "Provider: \(self.name)"
    }
    
    public init(sdkConfig: SdkConfig, providerConfig: ProviderConfig) {
        self.sdkConfig = sdkConfig
        self.providerConfig = providerConfig
        self.name = providerConfig.provider
        
        
        let frameworkBundle = Bundle(identifier: "org.cocoapods.IdentitySdkWebView")
        let storyboard = UIStoryboard(name: "WebView", bundle: frameworkBundle)
        let controller = storyboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
    }
    
    public func login(origin: String, viewController: UIViewController?) {
        print("WebViewProvider login")
        let webViewController = WebViewController()
        webViewController.sdkConfig = self.sdkConfig
        webViewController.providerConfig = self.providerConfig
        viewController?.present(webViewController, animated: true, completion: nil)
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
