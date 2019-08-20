import Foundation

public enum UpdatePasswordParams {
    case FreshAccessTokenParams(password: String)
    case AccessTokenParams(password: String, oldPassword: String)
    case EmailParams(email: String, verificationCode: String, password: String)
    case SmsParams(phoneNumber: String, verificationCode: String, password: String)
    case EmailWithClientIdParams(clientId: String, email: String, verificationCode: String, password: String)
    case SmsWithClientIdParams(clientId: String, phoneNumber: String, verificationCode: String, password: String)
}

public class UpdatePasswordRequest: Codable, DictionaryEncodable {
    let clientId: String?
    let password: String?
    let oldPassword: String?
    let email: String?
    let phoneNumber: String?
    let verificationCode: String?
    
    public init(
        clientId: String? = nil,
        password: String? = nil,
        oldPassword: String? = nil,
        email: String? = nil,
        phoneNumber: String? = nil,
        verificationCode: String? = nil
    ) {
        self.clientId = clientId
        self.password = password
        self.oldPassword = oldPassword
        self.email = email
        self.phoneNumber = phoneNumber
        self.verificationCode = verificationCode
    }
    
    public convenience init(updatePasswordParams: UpdatePasswordParams) {
        switch updatePasswordParams {
        case .FreshAccessTokenParams(let password):
            self.init(password: password)
        case .AccessTokenParams(let password, let oldPassword):
            self.init(password: password, oldPassword: oldPassword)
        case .EmailParams(let email, let verificationCode, let password):
            self.init(password: password, email: email, verificationCode: verificationCode)
        case .SmsParams(let phoneNumber, let verificationCode, let password):
            self.init(password: password, phoneNumber: phoneNumber, verificationCode: verificationCode)
        case .EmailWithClientIdParams(let clientId, let email, let verificationCode, let password):
            self.init(clientId: clientId, password: verificationCode, oldPassword: password, email: email)
        case .SmsWithClientIdParams(let clientId, let phoneNumber, let verificationCode, let password):
            self.init(clientId: clientId, password: verificationCode, oldPassword: password, phoneNumber: phoneNumber)
        }
    }
}
