import Foundation
import ObjectMapper

public class Profile: NSObject, ImmutableMappable {
    let email: String
    let password: String
    let phoneNumber: String?
    let gender: String?
    let name: String?
    let givenName: String?
    let middleName: String?
    let familyName: String?
    let nickname: String?
    let username: String?
    let birthdate: String?
    let picture: String?
    let company: String?
    let locale: String?
    let address: ProfileAddress?
    let customFields: Dictionary<String, Any>?
    
    public init(email: String, password: String, phoneNumber: String?, gender: String?, name: String?, givenName: String?, middleName: String?, familyName: String?, nickname: String?, username: String?, birthdate: String?, picture: String?, company: String?, locale: String?, address: ProfileAddress?, customFields: Dictionary<String, Any>?) {
        self.email = email
        self.password = password
        self.phoneNumber = phoneNumber
        self.gender = gender
        self.name = name
        self.givenName = givenName
        self.middleName = middleName
        self.familyName = familyName
        self.nickname = nickname
        self.username = username
        self.birthdate = birthdate
        self.picture = picture
        self.company = company
        self.locale = locale
        self.address = address
        self.customFields = customFields
    }
    
    public required init(map: Map) throws {        
        email = try map.value("email")
        password = try map.value("password")
        phoneNumber = try? map.value("phone_number")
        gender = try? map.value("gender")
        name = try? map.value("name")
        givenName = try? map.value("given_name")
        middleName = try? map.value("middle_name")
        familyName = try? map.value("family_name")
        nickname = try? map.value("nickname")
        username = try? map.value("username")
        birthdate = try? map.value("birthdate")
        picture = try? map.value("picture")
        company = try? map.value("company")
        locale = try? map.value("locale")
        address = try? map.value("address")
        customFields = try? map.value("custom_fields")
    }
    
    public func mapping(map: Map) {
        email >>> map["email"]
        password >>> map["password"]
        phoneNumber >>> map["phone_number"]
        gender >>> map["gender"]
        name >>> map["name"]
        givenName >>> map["given_name"]
        middleName >>> map["middle_name"]
        familyName >>> map["family_name"]
        nickname >>> map["nickname"]
        username >>> map["username"]
        birthdate >>> map["birthdate"]
        picture >>> map["picture"]
        company >>> map["company"]
        locale >>> map["locale"]
        address >>> map["address"]
        customFields >>> map["custom_fields"]
    }
    
    public override var description: String {
        return self.toJSONString(prettyPrint: true) ?? super.description
    }
}

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

public class SignupRequest: NSObject, ImmutableMappable {
    let clientId: String
    let data: Profile
    let scope: String
    let acceptTos: Bool?
    
    public init(clientId: String, data: Profile, scope: String, acceptTos: Bool?) {
        self.clientId = clientId
        self.data = data
        self.scope = scope
        self.acceptTos = acceptTos
    }

    public required init(map: Map) throws {
        clientId = try map.value("client_id")
        data = try map.value("data")
        scope = try map.value("scope")
        acceptTos = try? map.value("accep_tos")
    }

    public func mapping(map: Map) {
        clientId >>> map["client_id"]
        data >>> map["data"]
        scope >>> map["scope"]
        acceptTos >>> map["accept_tos"]
    }
    
    public override var description: String {
        return self.toJSONString(prettyPrint: true) ?? super.description
    }
}
