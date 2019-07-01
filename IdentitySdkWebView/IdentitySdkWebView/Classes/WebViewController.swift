import Foundation
import UIKit
import WebKit
import IdentitySdkCore

public class WebViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    var webView: WKWebView!
    
    var sdkConfig: SdkConfig? = nil
    var providerConfig: ProviderConfig? = nil
    
    public override func loadView() {
        super.viewDidLoad()
        //let configuration = WKWebViewConfiguration()
        //configuration.setURLSchemeHandler(SchemeHandler(), forURLScheme: "reachfive")
        webView = WKWebView(/*frame: .zero, configuration: configuration*/)
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = self
        view = webView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        let urlString = buildUrl(sdkConfig: self.sdkConfig!, providerConfig: self.providerConfig!)
        print("viewDidLoad \(urlString)")
        let url = URL(string: urlString)!
        webView.load(URLRequest(url: url))
    }
    
    func loadHtml(html: String) {
        webView.loadHTMLString(html, baseURL: nil)
    }
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("webView didStartProvisionalNavigation \(String(describing: webView.url?.absoluteString))")
        
        let scheme = webView.url?.scheme
        let queries = webView.url?.query
        
        if scheme == "reachfive" && queries != nil {
            let params = parseQueriesStrings(query: queries!)
            print("INTERCEPTED scheme \((navigationController == nil)) \(params)")
            decisionHandler(.cancel)
            navigationController?.popViewController(animated: true)
        } else {
            decisionHandler(.allow)
        }
    }
    
    func parseQueriesStrings(query: String) -> Dictionary<String, String?> {
        return query.split(separator: "&").reduce(Dictionary<String, String?>(), { ( acc, param) in
            var mutAcc = acc
            let splited = param.split(separator: "=")
            let key: String = String(splited.first!)
            let value: String? = splited.count > 1 ? String(splited[1]) : nil
            mutAcc.updateValue(value, forKey: key)
            return mutAcc
        })
    }
    
    /*
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("webView didStartProvisionalNavigation \(String(describing: webView.url?.absoluteString))")
    }
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("webView didFinish \(String(describing: webView.url?.absoluteString))")
    }
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("webView didFail \(String(describing: webView.url?.absoluteString))")
    }
    
    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("webView url=\(webView.url?.absoluteString.description) \(error.localizedDescription)")
    }
    */
    
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

class SchemeHandler: NSObject, WKURLSchemeHandler {
    func webView(_ webView: WKWebView, start urlSchemeTask: WKURLSchemeTask) {
        print("SchemeHandler.webView.start \(webView.url?.absoluteString)")
    }
    
    func webView(_ webView: WKWebView, stop urlSchemeTask: WKURLSchemeTask) {
        print("SchemeHandler.webView.stop \(webView.url?.absoluteString)")
    }
}
