import Foundation
import ObjectMapper

public class OpenIdUser: NSObject, ImmutableMappable {
    let id: String?
    let name: String?
    let email: String?
    // TODO add others fields
    
    public func fromIdToken(idToken: String) -> Result<OpenIdUser, ReachFiveError> {
        let parts = idToken.components(separatedBy: ".")
        if parts.count == 3 {
            let data = base64decode(parts[1])
            let content = String(data: data!, encoding: .utf8)
            let user = Result.init(catching: {
                return try OpenIdUser(JSONString: content!)
            })
            return user.mapError({ error in
                return ReachFiveError.AuthFailure(reason: error.localizedDescription) // TODO add specifique error
            })
        } else {
            return .failure(.AuthFailure(reason: "idToken invalid"))
        }
    }
    
    func base64decode(_ input: String) -> Data? {
        let rem = input.count % 4
        
        var ending = ""
        if rem > 0 {
            let amount = 4 - rem
            ending = String(repeating: "=", count: amount)
        }
        
        let base64 = input.replacingOccurrences(of: "-", with: "+", options: NSString.CompareOptions(rawValue: 0), range: nil)
            .replacingOccurrences(of: "_", with: "/", options: NSString.CompareOptions(rawValue: 0), range: nil) + ending
        
        return Data(base64Encoded: base64, options: NSData.Base64DecodingOptions(rawValue: 0))
    }
    
    public init(id: String?, name: String?, email: String?) {
        self.id = id
        self.name = name
        self.email = email
    }
    
    public required init(map: Map) throws {
        id = try? map.value("sub")
        name = try? map.value("name")
        email = try? map.value("email")
    }
    
    public func mapping(map: Map) {
        id >>> map["sub"]
        name >>> map["name"]
        email >>> map["email"]
    }
    
    public override var description: String {
        return self.toJSONString(prettyPrint: true) ?? super.description
    }
}

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
    
    public static func fromOpenIdTokenResponse(openIdTokenResponse: OpenIdTokenResponse) -> Result<AuthToken, ReachFiveError> {
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

public class OpenIdTokenResponse: NSObject, ImmutableMappable {
    let idToken: String?
    let accessToken: String?
    let code: String?
    let tokenType: String?
    let expiresIn: Int?
    let error: String?
    let errorDescription: String?
    
    public init(idToken: String?, accessToken: String?, code: String?, tokenType: String?, expiresIn: Int?, error: String?, errorDescription: String?) {
        self.idToken = idToken
        self.accessToken = accessToken
        self.code = code
        self.tokenType = tokenType
        self.expiresIn = expiresIn
        self.error = error
        self.errorDescription = errorDescription
    }

    public required init(map: Map) throws {
        idToken = try? map.value("id_token")
        accessToken = try? map.value("access_token")
        code = try? map.value("code")
        tokenType = try? map.value("token_type")
        expiresIn = try? map.value("expires_in")
        error = try? map.value("error")
        errorDescription = try? map.value("error_description")
    }

    public func mapping(map: Map) {
        idToken >>> map["id_token"]
        accessToken >>> map["access_token"]
        code >>> map["code"]
        tokenType >>> map["token_type"]
        expiresIn >>> map["expires_in"]
        error >>> map["error"]
        errorDescription >>> map["error_description"]
    }
    
    public override var description: String {
        return self.toJSONString(prettyPrint: true) ?? super.description
    }
}
