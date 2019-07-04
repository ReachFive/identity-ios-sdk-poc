import Foundation
import ObjectMapper

public class OpenIdUser: NSObject, ImmutableMappable {
    let id: String?
    let name: String?
    let email: String?
    // TODO add others fields
    
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

