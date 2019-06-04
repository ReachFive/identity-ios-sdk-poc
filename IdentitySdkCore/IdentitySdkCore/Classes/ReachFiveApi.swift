import Foundation
import Alamofire
import AlamofireObjectMapper

typealias ResponseHandler<T> = (_ response: DataResponse<T>) -> Void

public class ReachFiveApi {
    let sdkConfig: SdkConfig
    
    public init(sdkConfig: SdkConfig) {
        self.sdkConfig = sdkConfig
    }
    
    public func providersConfigs(success: @escaping Success<ProvidersConfigsResult>, failure: @escaping Failure<Error>) {
        Alamofire
            .request(createUrl(path: "/api/v1/providers"))
            .responseObject(completionHandler: handleResponse(success: success, failure: failure))
    }
    
    public func signupWithPassword(signupRequest: SignupRequest, success: @escaping Success<ProvidersConfigsResult>, failure: @escaping Failure<Error>) {
        Alamofire
            .request(createUrl(path: "/identity/v1/signup-token"), method: .post, parameters: signupRequest.toJSON(), encoding: JSONEncoding.default)
    }
    
    func handleResponse<T>(success: @escaping Success<T>, failure: @escaping Failure<Error>) -> ResponseHandler<T> {
        return {(response: DataResponse<T>) -> Void in
            switch response.result {
            case let .failure(error): failure(error)
            case let .success(value): success(value)
            }
        }
    }
    
    func createUrl(path: String) -> String {
        return "https://\(sdkConfig.domain)\(path)"
    }
}
