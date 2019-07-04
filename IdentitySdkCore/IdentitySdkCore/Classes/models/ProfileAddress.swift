import Foundation
import ObjectMapper

public class ProfileAddress: NSObject, ImmutableMappable {
    let country: String
    
    public init(country: String) {
        self.country = country
    }
    
    public required init(map: Map) throws {
        country = try map.value("country")
    }
    
    public func mapping(map: Map) {
        country >>> map["country"]
    }
    
    public override var description: String {
        return self.toJSONString(prettyPrint: true) ?? super.description
    }
}
