import Foundation

public class VerifyAuthCodeRequest: Codable, DictionaryEncodable {
    let authType: PasswordLessAuthType?
    let phoneNumber: String?
    let email: String?
    let verificationCode: String

    public init(
        authType: PasswordLessAuthType? = nil,
        phoneNumber: String? = nil,
        email: String? = nil,
        verificationCode: String
    ) {
        self.authType = authType
        self.phoneNumber = phoneNumber
        self.email = email
        self.verificationCode = verificationCode
    }
}
