import Foundation
import BrightFutures

public extension ReachFive {
    func signup(profile: ProfileSignupRequest, scope: [String]? = nil, callback: @escaping Callback<AuthToken, ReachFiveError>) {
        let signupRequest = SignupRequest(
            clientId: sdkConfig.clientId,
            data: profile,
            scope: (scope ?? self.scope).joined(separator: " "),
            acceptTos: nil
        )
        self.reachFiveApi.signupWithPassword(signupRequest: signupRequest, callback: handleAuthResponse(callback: callback))
    }
    
    @available(*, deprecated, message: "Please use the methode with Future")
    func loginWithPassword(
        username: String,
        password: String,
        scope: [String]? = nil,
        callback: @escaping Callback<AuthToken, ReachFiveError>
    ) {
        self.loginWithPassword(username: username, password: password, scope: scope)
            .onSuccess { authToken in
                callback(.success(authToken))
            }
            .onFailure { error in
                callback(.failure(error))
            }
    }
    
    func loginWithPassword(
        username: String,
        password: String,
        scope: [String]? = nil
    ) -> Future<AuthToken, ReachFiveError> {
        let loginRequest = LoginRequest(
            username: username,
            password: password,
            grantType: "password",
            clientId: sdkConfig.clientId,
            scope: (scope ?? self.scope).joined(separator: " ")
        )
        return self.reachFiveApi
            .loginWithPassword(loginRequest: loginRequest)
            .flatMap({ AuthToken.fromOpenIdTokenResponseFuture($0) })
    }
}
