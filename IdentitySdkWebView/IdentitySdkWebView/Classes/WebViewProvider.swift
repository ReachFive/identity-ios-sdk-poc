import Foundation
import IdentitySdkCore

public class WebViewProvider: ProviderCreator {
    public static let NAME = "webview"
    
    public var name: String = NAME
    
    public init() {}
    
    public func create(sdkConfig: SdkConfig, providerConfig: ProviderConfig, reachFiveApi: ReachFiveApi) -> Provider {
        return ConfiguredWebViewProvider(sdkConfig: sdkConfig, providerConfig: providerConfig, reachFiveApi: reachFiveApi)
    }
}

class ConfiguredWebViewProvider: NSObject, Provider {
    let sdkConfig: SdkConfig
    let providerConfig: ProviderConfig
    let reachFiveApi: ReachFiveApi
    var name: String = WebViewProvider.NAME
    
    override var description: String {
        return "Provider: \(self.name)"
    }
    
    public init(sdkConfig: SdkConfig, providerConfig: ProviderConfig, reachFiveApi: ReachFiveApi) {
        self.sdkConfig = sdkConfig
        self.providerConfig = providerConfig
        self.reachFiveApi = reachFiveApi
        self.name = providerConfig.provider
    }
    
    public func login(origin: String, viewController: UIViewController?, callback: @escaping (Result<String, ReachFiveError>) -> Void) {
        let frameworkBundle = Bundle(identifier: "org.cocoapods.IdentitySdkWebView")
        let storyboard = UIStoryboard(name: "WebView", bundle: frameworkBundle)
        let webViewController = storyboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        let url = self.buildUrl(sdkConfig: sdkConfig, providerConfig: providerConfig)
        print("WebViewProvider login url=\(url)")
        webViewController.url = url
        webViewController.delegate = {
            switch $0 {
            case .success(let params):
                let code = params["code"] as? String
                if code != nil {
                    let authCodeRequest = AuthCodeRequest(clientId: self.sdkConfig.clientId, code: code!)
                    self.reachFiveApi.authWithCode(authCodeRequest: authCodeRequest, callback: { response in
                        switch response {
                        case .success(let openIdTokenResponse): callback(.success(openIdTokenResponse.description))
                        case .failure(let error): callback(.failure(.AuthFailure(reason: error.localizedDescription))) // TODO harmonize error handling
                        }
                    })
                } else {
                    callback(.failure(.AuthFailure(reason: "No code")))
                }
            case .failure(let error):
                callback(.failure(.AuthFailure(reason: error.localizedDescription))) // TODO harmonize error handling
            }
        }
        viewController?.show(webViewController, sender: nil)
    }
    
    public func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return true
    }
    
    public func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        return true
    }
    
    public func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    func buildUrl(sdkConfig: SdkConfig, providerConfig: ProviderConfig) -> String {
        let params = [
            "provider": providerConfig.provider,
            "client_id": sdkConfig.clientId,
            "response_type": "code",
            "redirect_uri": "reachfive://callback",
            "scope": providerConfig.scope.joined(separator: " "),
            "platform": "ios"
        ]
        let queryStrings = params
            .map { "\($0)=\($1)" }
            .map { $0.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) }
            .filter { $0 != nil }
            .map { $0! }
            .joined(separator: "&")
        return "https://\(sdkConfig.domain)/oauth/authorize?\(queryStrings)"
    }
}
