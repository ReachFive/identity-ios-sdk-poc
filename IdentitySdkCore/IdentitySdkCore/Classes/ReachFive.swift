import Foundation

public class ReachFive: NSObject {
    
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
    
    public func initialize(success: @escaping Success<[Provider]>, failure: @escaping Failure<Error>) -> Self {
        reachFiveApi.providersConfigs(success: { providersConfigs in
            self.providers = self.createProviders(providersConfigsResult: providersConfigs)
            success(self.providers)
        }, failure: failure)
        print(self)
        return self
    }
    
    func createProviders(providersConfigsResult: ProvidersConfigsResult) -> [Provider] {
        let webViewProvider = providersCreators.first(where: { $0.name == "webview" })
        return providersConfigsResult.items.map({ config in
            let nativeProvider = providersCreators.first(where: { $0.name == config.provider })
            if (nativeProvider != nil) {
                return nativeProvider?.create(sdkConfig: sdkConfig)
            } else if (webViewProvider != nil) {
                return webViewProvider?.create(sdkConfig: sdkConfig)
            } else {
                return nil
            }
        }).compactMap { $0 }
    }
    
    public func signupWithPassword(profile: Profile, success: @escaping Success<Any /* TODO OpenIdTokenResponse*/>, failure: @escaping Failure<Error>) {
        let signupRequest = SignupRequest(
            clientId: sdkConfig.clientId,
            data: profile,
            scope: "openid profile email",
            acceptTos: nil
        )
        reachFiveApi.signupWithPassword(signupRequest: signupRequest, success: success, failure: failure)
    }
    
    public override var description: String {
        return """
        Config: domain=\(sdkConfig.domain), clientId=\(sdkConfig.clientId)
        Providers: \(providers)
        """
    }
}
