import Foundation

public class AuthToken: NSObject {
    let idToken: String?
    let accessToken: String?
    let tokenType: String?
    let expiresIn: Int?
    let user: OpenIdUser?
    
    public init(idToken: String?, accessToken: String?, tokenType: String?, expiresIn: Int?, user: OpenIdUser?) {
        self.idToken = idToken
        self.accessToken = accessToken
        self.tokenType = tokenType
        self.expiresIn = expiresIn
        self.user = user
    }
    
    public static func fromOpenIdTokenResponse(openIdTokenResponse: AccessTokenResponse) -> Result<AuthToken, ReachFiveError> {
        return .success(AuthToken(
            idToken: openIdTokenResponse.idToken,
            accessToken: openIdTokenResponse.accessToken,
            tokenType: openIdTokenResponse.tokenType,
            expiresIn: openIdTokenResponse.expiresIn,
            user: nil // TODO add user
        ))
    }
    
    public override var description: String {
        return "AuthToken(accessToken=\(String(describing: accessToken)) user=\(String(describing: user)))"
    }
}
