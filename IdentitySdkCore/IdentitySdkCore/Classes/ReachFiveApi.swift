import Foundation
import Alamofire
import AlamofireObjectMapper
import BrightFutures

typealias ResponseHandler<T> = (_ response: DataResponse<T>) -> Void

public class ReachFiveApi {
    let decoder = JSONDecoder()
    let sdkConfig: SdkConfig
    
    let deviceInfo: String = "\(UIDevice.current.modelName) \(UIDevice.current.systemName) \(UIDevice.current.systemVersion)"
        .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    
    public init(sdkConfig: SdkConfig) {
        self.sdkConfig = sdkConfig
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    public func clientConfig() -> Future<ClientConfigResponse, ReachFiveError> {
        return Alamofire
            .request(createUrl(path: "/identity/v1/config?client_id=\(sdkConfig.clientId)"))
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJson(type: ClientConfigResponse.self, decoder: self.decoder)
    }
    
    public func providersConfigs() -> Future<ProvidersConfigsResult, ReachFiveError> {
        return Alamofire
            .request(createUrl(path: "/api/v1/providers?platform=ios&device=\(deviceInfo)"))
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJson(type: ProvidersConfigsResult.self, decoder: self.decoder)
    }
    
    public func loginWithProvider(
        loginProviderRequest: LoginProviderRequest
    ) -> Future<AccessTokenResponse, ReachFiveError> {
        return Alamofire
            .request(createUrl(path: "/identity/v1/oauth/provider/token?device=\(deviceInfo)"), method: .post, parameters: loginProviderRequest.toJSON(), encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJson(type: AccessTokenResponse.self, decoder: self.decoder)
    }
    
    public func signupWithPassword(signupRequest: SignupRequest, callback: @escaping Callback<AccessTokenResponse, ReachFiveError>) {
        Alamofire
            .request(createUrl(path: "/identity/v1/signup-token?device=\(deviceInfo)"), method: .post, parameters: signupRequest.toJSON(), encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseObject(completionHandler: handleResponse(callback: callback))
    }
    
    public func loginWithPassword(loginRequest: LoginRequest) -> Future<AccessTokenResponse, ReachFiveError> {
        return Alamofire
            .request(
                createUrl(path: "/oauth/token?device=\(deviceInfo)"),
                method: .post,
                parameters: loginRequest.dictionary(),
                encoding: JSONEncoding.default
            )
            .validate(contentType: ["application/json"])
            .responseJson(type: AccessTokenResponse.self, decoder: self.decoder)
    }
    
    public func authWithCode(authCodeRequest: AuthCodeRequest) -> Future<AccessTokenResponse, ReachFiveError> {
        return Alamofire
            .request(
                createUrl(path: "/oauth/token?device=\(deviceInfo)"),
                method: .post,
                parameters: authCodeRequest.dictionary(),
                encoding: JSONEncoding.default
            )
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJson(type: AccessTokenResponse.self, decoder: self.decoder)
    }
    
    public func getProfile(authToken: AuthToken, callback: @escaping Callback<Profile, ReachFiveError>) {
        Alamofire
            .request(
                createUrl(path: "/identity/v1/me?device=\(deviceInfo)"),
                method: .get,
                headers: tokenHeader(authToken)
            )
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseObject(completionHandler: handleResponse(callback: callback))
    }
    
    public func verifyPhoneNumber(
        authToken: AuthToken,
        verifyPhoneNumberRequest: VerifyPhoneNumberRequest
    ) -> Future<Void, ReachFiveError> {
        return Alamofire
            .request(
                createUrl(path: "/identity/v1/verify-phone-number?device=\(deviceInfo)"),
                method: .post,
                parameters: verifyPhoneNumberRequest.dictionary(),
                encoding: JSONEncoding.default,
                headers: tokenHeader(authToken)
            )
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJson(decoder: self.decoder)
    }

    public func updateEmail(authToken: AuthToken, updateEmailRequest: UpdateEmailRequest, callback: @escaping Callback<Profile, ReachFiveError>) {
        Alamofire
            .request(
                createUrl(path: "/identity/v1/update-email?device=\(deviceInfo)"),
                method: .post,
                parameters: updateEmailRequest.toJSON(),
                encoding: JSONEncoding.default,
                headers: tokenHeader(authToken)
            )
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseObject(completionHandler: handleResponse(callback: callback))
    }
    
    public func updateProfile(
        authToken: AuthToken,
        profile: Profile,
        callback: @escaping Callback<Profile, ReachFiveError>
    ) {
        Alamofire
            .request(
                createUrl(path: "/identity/v1/update-profile?device=\(deviceInfo)"),
                method: .post,
                parameters: profile.toJSON(),
                encoding: JSONEncoding.default,
                headers: tokenHeader(authToken)
            )
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseObject(completionHandler: handleResponse(callback: callback))
    }
    
    public func updatePassword(
        authToken: AuthToken,
        updatePasswordRequest: UpdatePasswordRequest,
        callback: @escaping Callback<Void, ReachFiveError>
    ) {
        Alamofire
            .request(
                createUrl(path: "/identity/v1/update-password?device=\(deviceInfo)"),
                method: .post,
                parameters: updatePasswordRequest.toJSON(),
                encoding: JSONEncoding.default,
                headers: tokenHeader(authToken)
            )
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .response(completionHandler: handleVoidResponse(callback: callback))
    }
    
    public func requestPasswordReset(
        authToken: AuthToken,
        requestPasswordResetRequest: RequestPasswordResetRequest,
        callback: @escaping Callback<Void, ReachFiveError>
    ) {
        Alamofire
            .request(createUrl(
                path: "/identity/v1/forgot-password?device=\(deviceInfo)"),
                method: .post,
                parameters: requestPasswordResetRequest.toJSON(),
                encoding: JSONEncoding.default,
                headers: tokenHeader(authToken)
            )
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .response(completionHandler: handleVoidResponse(callback: callback))
    }
    
    public func logout(authToken: AuthToken) -> Future<Void, ReachFiveError> {
        return Alamofire
            .request(createUrl(
                path: "/identity/v1/logout?device=\(deviceInfo)"),
                method: .get,
                headers: tokenHeader(authToken)
            )
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJson(decoder: self.decoder)
    }
    
    func handleVoidResponse(callback: @escaping Callback<Void, ReachFiveError>) -> (DefaultDataResponse) -> Void {
        return {(response: DefaultDataResponse) -> Void in
            if response.error != nil {
                callback(.failure(.TechnicalError(reason: response.error!.localizedDescription)))
            } else {
                callback(.success(()))
            }
        }
    }
    
    func handleResponse<T>(callback: @escaping Callback<T, ReachFiveError>) -> ResponseHandler<T> {
        return {(response: DataResponse<T>) -> Void in
            let data = response.data
            switch response.result {
            case let .failure(error):
                if response.response?.statusCode == 400 && data != nil {
                    let body = String(decoding: data!, as: UTF8.self)
                    let requestErrors = try? RequestErrors(JSONString: body)
                    callback(.failure(.RequestError(requestErrors: requestErrors!)))
                } else {
                    callback(.failure(.TechnicalError(reason: error.localizedDescription)))
                }
            case let .success(value):
                callback(.success(value))
            }
        }
    }
    
    func tokenHeader(_ authToken: AuthToken) -> [String: String] {
        return ["Authorization": "\(authToken.tokenType ?? "Bearer") \(authToken.accessToken)"]
    }
    
    func createUrl(path: String) -> String {
        return "https://\(sdkConfig.domain)\(path)"
    }
}
