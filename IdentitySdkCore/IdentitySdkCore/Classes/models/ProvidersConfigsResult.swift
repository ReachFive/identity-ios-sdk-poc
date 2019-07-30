import Foundation
import ObjectMapper

public class ProvidersConfigsResult: Codable {
    let items: [ProviderConfig]
    let status: String
}
