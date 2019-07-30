import Foundation
import PromiseKit

public extension ReachFive {
    
    @available(*, deprecated, message: "Please use the methode with Promise")
    func signup(profile: ProfileSignupRequest, scope: [String]? = nil, callback: @escaping Callback<AuthToken, ReachFiveError>) {
        self.signup(profile: profile, scope: scope)
            .done({ authToken in callback(.success(authToken)) })
            .catch({ error in callback(.failure(ReachFiveError.TechnicalError(reason: error.localizedDescription))) })
    }
    
    func signup(profile: ProfileSignupRequest, scope: [String]? = nil) -> Promise<AuthToken> {
        let signupRequest = SignupRequest(
            clientId: sdkConfig.clientId,
            data: profile,
            scope: (scope ?? self.scope).joined(separator: " "),
            acceptTos: nil
        )
        return self.reachFiveApi
            .signupWithPassword(signupRequest: signupRequest)
            .then(AuthToken.fromOpenIdTokenResponse)
    }
    
    func loginWithPassword(username: String, password: String, scope: [String]? = nil, callback: @escaping Callback<AuthToken, ReachFiveError>) {
        let loginRequest = LoginRequest(
            username: username,
            password: password,
            grantType: "password",
            clientId: sdkConfig.clientId,
            scope: (scope ?? self.scope).joined(separator: " ")
        )
        self.reachFiveApi.loginWithPassword(loginRequest: loginRequest, callback: handleAuthResponse(callback: callback))
    }
}
