import Foundation

public class ReachFive {
    
    let sdkConfig: SdkConfig
    let providersCreators: Array<ProviderCreator>
    let reachFiveApi: ReachFiveApi
    
    public init(sdkConfig: SdkConfig, providersCreators: Array<ProviderCreator>) {
        self.sdkConfig = sdkConfig
        self.providersCreators = providersCreators
        self.reachFiveApi = ReachFiveApi(sdkConfig: sdkConfig)
    }
    
    public func initialize() {
        print(reachFiveApi.providersConfigs())
        show()
    }
    
    func show() {
        print(sdkConfig.domain)
        print(sdkConfig.clientId)
        
        for providersCreator in providersCreators {
            print(providersCreator.create(sdkConfig: sdkConfig).helloWorld())
        }
    }
}
