import Foundation

public class ReachFive {
    
    let sdkConfig: SdkConfig
    let providersCreators: Array<ProviderCreator>
    
    public init(sdkConfig: SdkConfig, providersCreators: Array<ProviderCreator>) {
        self.sdkConfig = sdkConfig
        self.providersCreators = providersCreators
    }
}
