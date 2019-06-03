import Foundation
import Alamofire

public class ReachFiveApi {
    let sdkConfig: SdkConfig
    
    public init(sdkConfig: SdkConfig) {
        self.sdkConfig = sdkConfig
    }
    
    public func providersConfigs() -> ProvidersConfigsResult {
        Alamofire.request("https://\(sdkConfig.domain)/api/v1/providers").responseJSON { response in
            print(response.value)
        }
        return ProvidersConfigsResult()
    }
}
