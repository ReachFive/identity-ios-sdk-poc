import Foundation

enum State {
    case NotInitialazed
    case Initialazed
}

public class ReachFive: NSObject {
    var state: State = .NotInitialazed
    let sdkConfig: SdkConfig
    let providersCreators: Array<ProviderCreator>
    let reachFiveApi: ReachFiveApi
    var providers: [Provider] = []
    
    public init(sdkConfig: SdkConfig, providersCreators: Array<ProviderCreator>) {
        self.sdkConfig = sdkConfig
        self.providersCreators = providersCreators
        self.reachFiveApi = ReachFiveApi(sdkConfig: sdkConfig)
    }
    
    public func getProvider(name: String) -> Provider? {
        return providers.first(where: { $0.name == name })
    }
    
    public func getProviders() -> [Provider] {
        return providers
    }
    
    public func initialize(callback: @escaping Callback<[Provider], Error>) {
        print("initialize \(state)")
        switch self.state {
        case .NotInitialazed:
            reachFiveApi.providersConfigs(callback: { result in
                callback(result.map({ providersConfigs in
                    let providers = self.createProviders(providersConfigsResult: providersConfigs)
                    self.providers = providers
                    self.state = .Initialazed
                    return providers
                }))
            })
        case .Initialazed:
            callback(.success(self.providers))
        }
    }
    
    public func initialize() {
        self.initialize(callback: { _ in })
    }
    
    func createProviders(providersConfigsResult: ProvidersConfigsResult) -> [Provider] {
        let webViewProvider = providersCreators.first(where: { $0.name == "webview" })
        print("createProviders.providersCreators \(providersCreators) webViewProvider=\(String(describing: webViewProvider))")
        return providersConfigsResult.items.map({ config in
            let nativeProvider = providersCreators.first(where: { $0.name == config.provider })
            
            print("createProviders.nativeProvider \(String(describing: nativeProvider))")
            
            if (nativeProvider != nil) {
                return nativeProvider?.create(sdkConfig: sdkConfig, providerConfig: config, reachFiveApi: reachFiveApi)
            } else if (webViewProvider != nil) {
                return webViewProvider?.create(sdkConfig: sdkConfig, providerConfig: config, reachFiveApi: reachFiveApi)
            } else {
                return nil
            }
        }).compactMap { $0 }
    }
    
    public func signupWithPassword(profile: Profile, callback: @escaping Callback<OpenIdTokenResponse, Error>) {
        let signupRequest = SignupRequest(
            clientId: sdkConfig.clientId,
            data: profile,
            scope: "openid profile email",
            acceptTos: nil
        )
        reachFiveApi.signupWithPassword(signupRequest: signupRequest, callback: callback)
    }
    
    public func loginWithPassword(username: String, password: String, callback: @escaping Callback<OpenIdTokenResponse, Error>) {
        let loginRequest = LoginRequest(
            username: username,
            password: password,
            grantType: "password",
            clientId: sdkConfig.clientId,
            scope: "openid profile email"
        )
        reachFiveApi.loginWithPassword(loginRequest: loginRequest, callback: callback)
    }
    
    public func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        for provider in providers {
            let _ = provider.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        }
        return true
    }
    
    public func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        for provider in providers {
            let _ = provider.application(app, open: url, options: options)
        }
        return true
    }
    
    public func applicationDidBecomeActive(_ application: UIApplication) {
        for provider in providers {
            let _ = provider.applicationDidBecomeActive(application)
        }
    }
    
    public override var description: String {
        return """
        Config: domain=\(sdkConfig.domain), clientId=\(sdkConfig.clientId)
        Providers: \(providers)
        """
    }
}
