import Foundation
import PromiseKit

public class AuthToken: NSObject {
    public let idToken: String?
    public let accessToken: String
    public let tokenType: String?
    public let expiresIn: Int?
    public let user: OpenIdUser?
    
    public init(idToken: String?, accessToken: String, tokenType: String?, expiresIn: Int?, user: OpenIdUser?) {
        self.idToken = idToken
        self.accessToken = accessToken
        self.tokenType = tokenType
        self.expiresIn = expiresIn
        self.user = user
    }
    
    public static func fromOpenIdTokenResponse(_ openIdTokenResponse: AccessTokenResponse) -> Promise<AuthToken> {
        return Promise.init(resolver: { resolver in
            switch AuthToken.fromOpenIdTokenResponse(openIdTokenResponse: openIdTokenResponse) {
            case .success(let authToken): resolver.fulfill(authToken)
            case .failure(let error): resolver.reject(error)
            }
        })
    }
    
    public static func fromOpenIdTokenResponse(openIdTokenResponse: AccessTokenResponse) -> Swift.Result<AuthToken, ReachFiveError> {
        if openIdTokenResponse.idToken != nil {
            return fromIdToken(openIdTokenResponse.idToken!).flatMap { user in
                return .success(withUser(openIdTokenResponse, user))
            }
        } else {
            return .success(withUser(openIdTokenResponse, nil))
        }
    }
    
    static func withUser(_ accessTokenResponse: AccessTokenResponse, _ user: OpenIdUser?) -> AuthToken {
        return AuthToken(
            idToken: accessTokenResponse.idToken,
            accessToken: accessTokenResponse.accessToken,
            tokenType: accessTokenResponse.tokenType,
            expiresIn: accessTokenResponse.expiresIn,
            user: user
        )
    }
    
    static func fromIdToken(_ idToken: String) -> Swift.Result<OpenIdUser, ReachFiveError> {
        let parts = idToken.components(separatedBy: ".")
        if parts.count == 3 {
            let data = Base64.base64UrlSafeDecode(parts[1])
            let content = String(data: data!, encoding: .utf8)
            let user = Swift.Result.init(catching: {
                return try OpenIdUser(JSONString: content!)
            })
            return user.mapError({ error in
                return .TechnicalError(reason: error.localizedDescription)
            })
        } else {
            return .failure(.TechnicalError(reason: "idToken invalid"))
        }
    }
    
    public override var description: String {
        return "AuthToken(accessToken=\(String(describing: accessToken)) user=\(String(describing: user)))"
    }
}
