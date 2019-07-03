import Foundation
import Alamofire
import AlamofireObjectMapper

typealias ResponseHandler<T> = (_ response: DataResponse<T>) -> Void

public class ReachFiveApi {
    let sdkConfig: SdkConfig
    
    public init(sdkConfig: SdkConfig) {
        self.sdkConfig = sdkConfig
    }
    
    public func providersConfigs(callback: @escaping Callback<ProvidersConfigsResult, Error>) {
        Alamofire
            .request(createUrl(path: "/api/v1/providers?platform=ios"))
            //.validate(statusCode: 200..<300)
            //.validate(contentType: ["application/json"])
            .responseObject(completionHandler: handleResponse(callback: callback))
    }
    
    public func signupWithPassword(signupRequest: SignupRequest, callback: @escaping Callback<OpenIdTokenResponse, Error>) {
        Alamofire
            .request(createUrl(path: "/identity/v1/signup-token"), method: .post, parameters: signupRequest.toJSON(), encoding: JSONEncoding.default)
            .responseObject(completionHandler: handleResponse(callback: callback))
    }
    
    public func loginWithPassword(loginRequest: LoginRequest, callback: @escaping Callback<OpenIdTokenResponse, Error>) {
        Alamofire
            .request(createUrl(path: "/oauth/token"), method: .post, parameters: loginRequest.toJSON(), encoding: JSONEncoding.default)
            .responseObject(completionHandler: handleResponse(callback: callback))
    }
    
    public func authWithCode(authCodeRequest: AuthCodeRequest, callback: @escaping Callback<OpenIdTokenResponse, Error>) {
        Alamofire
            .request(createUrl(path: "/oauth/token"), method: .post, parameters: authCodeRequest.toJSON(), encoding: JSONEncoding.default)
            .responseObject(completionHandler: handleResponse(callback: callback))
    }
    
    func handleResponse<T>(callback: @escaping Callback<T, Error>) -> ResponseHandler<T> {
        return {(response: DataResponse<T>) -> Void in
            switch response.result {
            case let .failure(error): callback(.failure(error))
            case let .success(value): callback(.success(value))
            }
        }
    }
    
    func createUrl(path: String) -> String {
        return "https://\(sdkConfig.domain)\(path)"
    }
}
