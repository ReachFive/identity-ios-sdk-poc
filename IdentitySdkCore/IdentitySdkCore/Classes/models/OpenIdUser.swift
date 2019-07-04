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
                return .TechnicalError(reason: error.localizedDescription)
            })
        } else {
            return .failure(.TechnicalError(reason: "idToken invalid"))
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

