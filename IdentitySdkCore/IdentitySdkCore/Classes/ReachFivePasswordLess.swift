import Foundation
import BrightFutures

public enum PasswordLessRequest {
    case Email(email: String)
    case PhoneNumber(phoneNumber: String)
}

public extension ReachFive {
    
    func addPasswordlessCallback(passwordlessCallback: @escaping PasswordlessCallback) {
        self.passwordlessCallback = passwordlessCallback
    }
        
    func startPasswordless(_ request: PasswordLessRequest) -> Future<(), ReachFiveError> {
        let pkce = Pkce.generate()
        self.storage.save(key: "PASSWORDLESS_PKCE", value: pkce)
        switch request {
        case .Email(let email):
            let startPasswordlessRequest = StartPasswordlessRequest(
                clientId: sdkConfig.clientId,
                email: email,
                authType: .MagicLink,
                codeChallenge: pkce.codeChallenge,
                codeChallengeMethod: pkce.codeChallengeMethod
            )
            return reachFiveApi.startPasswordless(startPasswordlessRequest)
        case .PhoneNumber(let phoneNumber):
            let startPasswordlessRequest = StartPasswordlessRequest(
                clientId: sdkConfig.clientId,
                phoneNumber: phoneNumber,
                authType: .SMS,
                codeChallenge: pkce.codeChallenge,
                codeChallengeMethod: pkce.codeChallengeMethod
            )
            return reachFiveApi.startPasswordless(startPasswordlessRequest)
        }
    }
    
    internal func interceptPasswordless(_ url: URL) {
        let params = QueriesStrings.parseQueriesStrings(query: url.query ?? "")
        let pkce: Pkce? = self.storage.take(key: "PASSWORDLESS_PKCE")
        if (pkce != nil) {
            if let state = params["state"] {
                if state == "passwordless" {
                    if let code = params["code"] {
                        print("interceptPasswordless code=\(String(describing: code))")
                        let authCodeRequest = AuthCodeRequest(clientId: self.sdkConfig.clientId, code: code ?? "", pkce: pkce!)
                        
                        self.reachFiveApi.authWithCode(authCodeRequest: authCodeRequest)
                            .flatMap({ AuthToken.fromOpenIdTokenResponseFuture($0) })
                            .onComplete { result in
                                self.passwordlessCallback?(result)
                            }
                    }
                }
            }
        } else {
            self.passwordlessCallback?(.failure(.TechnicalError(reason: "Pkce not found")))
        }
    }
}
