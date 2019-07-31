import Foundation
import BrightFutures

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
    
    public static func fromOpenIdTokenResponseFuture(
        _ openIdTokenResponse: AccessTokenResponse
    ) -> Future<AuthToken, ReachFiveError> {
        let promise = Promise<AuthToken, ReachFiveError>()
        let authTokenResult = AuthToken.fromOpenIdTokenResponse(openIdTokenResponse: openIdTokenResponse)
        promise.complete(authTokenResult)
        return promise.future
    }
    
    public static func fromOpenIdTokenResponse(openIdTokenResponse: AccessTokenResponse) -> Result<AuthToken, ReachFiveError> {
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
    
    static func fromIdToken(_ idToken: String) -> Result<OpenIdUser, ReachFiveError> {
        let parts = idToken.components(separatedBy: ".")
        if parts.count == 3 {
            let data = Base64.base64UrlSafeDecode(parts[1])
            let content = String(data: data!, encoding: .utf8)
            let user = Result.init(catching: {
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
