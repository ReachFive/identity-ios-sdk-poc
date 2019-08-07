import Foundation
import BrightFutures

public enum PasswordLessRequest {
    case Email(email: String)
    case PhoneNumber(phoneNumber: String)
}

public extension ReachFive {
    func startPasswordless(_ request: PasswordLessRequest) -> Future<(), ReachFiveError> {
        switch request {
        case .Email(let email):
            let startPasswordlessRequest = StartPasswordlessRequest(
                clientId: sdkConfig.clientId,
                email: email,
                authType: .MagicLink
            )
            return reachFiveApi.startPasswordless(startPasswordlessRequest)
        case .PhoneNumber(let phoneNumber):
            let startPasswordlessRequest = StartPasswordlessRequest(
                clientId: sdkConfig.clientId,
                phoneNumber: phoneNumber,
                authType: .SMS
            )
            return reachFiveApi.startPasswordless(startPasswordlessRequest)
        }
    }
    
    internal func interceptPasswordless(_ url: URL) {
        let params = QueriesStrings.parseQueriesStrings(query: url.query ?? "")
        if let state = params["state"] {
            if state == "passwordless" {
                if let code = params["code"] {
                    let fakePkce = Pkce.generate()
                    let authCodeRequest = AuthCodeRequest(clientId: self.sdkConfig.clientId, code: code ?? "", pkce: fakePkce)
                    self.reachFiveApi.authWithCode(authCodeRequest: authCodeRequest)
                        .flatMap({ AuthToken.fromOpenIdTokenResponseFuture($0) })
                        .onSuccess { authToken in
                            print("passwordless success \(authToken.accessToken)")
                        }
                        .onFailure { error in
                            print("passwordless error \(error)")
                    }
                }
            }
        }
    }
}
