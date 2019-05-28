import Foundation

public struct ProviderConfig {
    let provider: String
    let clientId: String
    let clientSecret: String?
    let scope: Set<String>
}
