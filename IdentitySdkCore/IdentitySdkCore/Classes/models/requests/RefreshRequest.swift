import Foundation

public class RefreshRequest: Codable, DictionaryEncodable {
    public let clientId: String
    public let refreshToken: String
    public let redirectUri: String
    public let grantType: String
    
    public init(clientId: String, refreshToken: String) {
        self.clientId = clientId
        self.refreshToken = refreshToken
        self.redirectUri = ReachFive.REDIRECT_URI
        self.grantType = "refresh_token"
    }
}
