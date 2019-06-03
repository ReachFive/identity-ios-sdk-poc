import Foundation
import Alamofire
import AlamofireObjectMapper

public class ReachFiveApi {
    let sdkConfig: SdkConfig
    
    public init(sdkConfig: SdkConfig) {
        self.sdkConfig = sdkConfig
    }
    
    public func providersConfigs() -> ProvidersConfigsResult? {
        Alamofire
            .request("https://\(sdkConfig.domain)/api/v1/providers")
            .responseObject { (response: DataResponse<ProvidersConfigsResult>) in
                print(response.result.error!)
                print(response.result.value!)
            }
        return nil
    }
}
