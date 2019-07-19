import Foundation
import ObjectMapper

public class Profile: NSObject, ImmutableMappable {
    public let email: String?
    public let password: String
    public let phoneNumber: String?
    public let gender: String?
    public let name: String?
    public let givenName: String?
    public let middleName: String?
    public let familyName: String?
    public let nickname: String?
    public let username: String?
    public let birthdate: String?
    public let picture: String?
    public let company: String?
    public let locale: String?
    public let address: ProfileAddress?
    public let customFields: Dictionary<String, Any>?
    
    public init(
        email: String?,
        password: String,
        phoneNumber: String? = nil,
        gender: String? = nil,
        name: String? = nil,
        givenName: String? = nil,
        middleName: String? = nil,
        familyName: String? = nil,
        nickname: String? = nil,
        username: String? = nil,
        birthdate: String? = nil,
        picture: String? = nil,
        company: String? = nil,
        locale: String? = nil,
        address: ProfileAddress? = nil,
        customFields: Dictionary<String, Any>? = nil
    ) {
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
        email = try? map.value("email")
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

public class UserProfile: NSObject, ImmutableMappable {
    public let uid: String?
    public let signedUid: String?
    public let givenName: String?
    public let middleName: String?
    public let familyName: String?
    public let name: String?
    public let nickname: String?
    public let birthdate: String?
    public let profileURL: String?
    public let picture: String?
    public let externalId: String?
    public let authTypes: [String]?
    public let loginSummary: LoginSummary?
    public let username: String?
    public let gender: String?
    public let email: String?
    public let emailVerified: Bool?
    public let emails: Emails?
    public let phoneNumber: String?
    public let phoneNumberVerified: Bool?
    public let addresses: [Address]?
    public let locale: String?
    public let bio: String?
    public let customFields: [String: Any]?
    public let consents: [String: UserConsent]?
    public let tosAcceptedAt: String?
    public let createdAt: String?
    public let updatedAt: String?
    public let liteOnly: Bool?

    public init(
        uid: String?,
        signedUid: String?,
        givenName: String?,
        middleName: String?,
        familyName: String?,
        name: String?,
        nickname: String?,
        birthdate: String?,
        profileURL: String?,
        picture: String?,
        externalId: String?,
        authTypes: [String]?,
        loginSummary: LoginSummary?,
        username: String?,
        gender: String?,
        email: String?,
        emailVerified: Bool?,
        emails: Emails?,
        phoneNumber: String?,
        phoneNumberVerified: Bool?,
        addresses: [Address]?,
        locale: String?,
        bio: String?,
        customFields: [String: Any]?,
        consents: [String: UserConsent]?,
        tosAcceptedAt: String?,
        createdAt: String?,
        updatedAt: String?,
        liteOnly: Bool?
    ) {
        self.uid = uid
        self.signedUid = signedUid
        self.givenName = givenName
        self.middleName = middleName
        self.familyName = familyName
        self.name = name
        self.nickname = nickname
        self.birthdate = birthdate
        self.profileURL = profileURL
        self.picture = picture
        self.externalId = externalId
        self.authTypes = authTypes
        self.loginSummary = loginSummary
        self.username = username
        self.gender = gender
        self.email = email
        self.emailVerified = emailVerified
        self.emails = emails
        self.phoneNumber = phoneNumber
        self.phoneNumberVerified = phoneNumberVerified
        self.addresses = addresses
        self.locale = locale
        self.bio = bio
        self.customFields = customFields
        self.consents = consents
        self.tosAcceptedAt = tosAcceptedAt
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.liteOnly = liteOnly
    }

    public required init(map: Map) throws {
        uid = try? map.value("uid")
        signedUid = try? map.value("signed_uid")
        givenName = try? map.value("given_name")
        middleName = try? map.value("middle_name")
        familyName = try? map.value("family_name")
        name = try? map.value("name")
        nickname = try? map.value("nickname")
        birthdate = try? map.value("birthdate")
        profileURL = try? map.value("profile_url")
        picture = try? map.value("picture")
        externalId = try? map.value("external_id")
        authTypes = try? map.value("auth_types")
        loginSummary = try? map.value("login_summary")
        username = try? map.value("username")
        gender = try? map.value("gender")
        email = try? map.value("email")
        emailVerified = try? map.value("email_verified")
        emails = try? map.value("emails")
        phoneNumber = try? map.value("phone_number")
        phoneNumberVerified = try? map.value("phone_number_verified")
        addresses = try? map.value("addresses")
        locale = try? map.value("locale")
        bio = try? map.value("bio")
        customFields = try? map.value("custom_fields")
        consents = try? map.value("consents")
        tosAcceptedAt = try? map.value("tos_accepted_at")
        createdAt = try? map.value("created_at")
        updatedAt = try? map.value("updated_at")
        liteOnly = try? map.value("lite_only")
    }

    public func mapping(map: Map) {
        uid >>> map["uid"]
        signedUid >>> map["signed_uid"]
        givenName >>> map["given_name"]
        middleName >>> map["middle_name"]
        familyName >>> map["family_name"]
        name >>> map["name"]
        nickname >>> map["nickname"]
        birthdate >>> map["birthdate"]
        profileURL >>> map["profile_url"]
        picture >>> map["picture"]
        externalId >>> map["external_id"]
        authTypes >>> map["auth_types"]
        loginSummary >>> map["login_summary"]
        username >>> map["username"]
        gender >>> map["gender"]
        email >>> map["email"]
        emailVerified >>> map["email_verified"]
        emails >>> map["emails"]
        phoneNumber >>> map["phone_number"]
        phoneNumberVerified >>> map["phone_number_verified"]
        addresses >>> map["addresses"]
        locale >>> map["locale"]
        bio >>> map["bio"]
        customFields >>> map["custom_fields"]
        consents >>> map["consents"]
        tosAcceptedAt >>> map["tos_accepted_at"]
        createdAt >>> map["created_at"]
        updatedAt >>> map["updated_at"]
        liteOnly >>> map["lite_only"]
    }
    
    public override var description: String {
        return self.toJSONString(prettyPrint: true) ?? super.description
    }
}

public class Emails: NSObject, ImmutableMappable {
    public let verified: [String]?
    public let unverified: [String]?
    
    public init(verified: [String]?, unverified: [String]?) {
        self.verified = verified
        self.unverified = unverified
    }

    public required init(map: Map) throws {
        verified = try? map.value("verified")
        unverified = try? map.value("unverified")
    }

    public func mapping(map: Map) {
        verified >>> map["verified"]
        unverified >>> map["unverified"]
    }
    
    public override var description: String {
        return self.toJSONString(prettyPrint: true) ?? super.description
    }
}

public class UserConsent: NSObject, ImmutableMappable {
    public let granted: Bool
    public let consentType: String?
    public let date: String

    public init(
        granted: Bool,
        consentType: String?,
        date: String
    ) {
        self.granted = granted
        self.consentType = consentType
        self.date = date
    }

    public required init(map: Map) throws {
        granted = try map.value("granted")
        consentType = try? map.value("consent_type")
        date = try map.value("date")
    }

    public func mapping(map: Map) {
        granted >>> map["granted"]
        consentType >>> map["consent_type"]
        date >>> map["date"]
    }
    
    public override var description: String {
        return self.toJSONString(prettyPrint: true) ?? super.description
    }
}

public class LoginSummary: NSObject, ImmutableMappable {
    public let firstLogin: Int?
    public let lastLogin: Int?
    public let total: Int?
    public let origins: [String]?
    public let devices: [String]?
    public let lastProvider: String?

    public init(
        firstLogin: Int?,
        lastLogin: Int?,
        total: Int?,
        origins: [String]?,
        devices: [String]?,
        lastProvider: String?
    ) {
        self.firstLogin = firstLogin
        self.lastLogin = lastLogin
        self.total = total
        self.origins = origins
        self.devices = devices
        self.lastProvider = lastProvider
    }

    public required init(map: Map) throws {
        firstLogin = try? map.value("first_login")
        lastLogin = try? map.value("last_login")
        total = try? map.value("total")
        origins = try? map.value("origins")
        devices = try? map.value("devices")
        lastProvider = try? map.value("last_provider")
    }

    public func mapping(map: Map) {
        firstLogin >>> map["first_login"]
        lastLogin >>> map["last_login"]
        total >>> map["total"]
        origins >>> map["origins"]
        devices >>> map["devices"]
        lastProvider >>> map["last_provider"]
    }
    
    public override var description: String {
        return self.toJSONString(prettyPrint: true) ?? super.description
    }
}

public class Address: NSObject, ImmutableMappable {
    public let title: String?
    public let isDefault: Bool?
    public let addressType: String?
    public let streetAddress: String?
    public let locality: String?
    public let region: String?
    public let postalCode: String?
    public let country: String?
    public let raw: String?
    public let deliveryNote: String?
    public let recipient: String?
    public let company: String?
    public let phoneNumber: String?

    public init(
        title: String?,
        isDefault: Bool?,
        addressType: String?,
        streetAddress: String?,
        locality: String?,
        region: String?,
        postalCode: String?,
        country: String?,
        raw: String?,
        deliveryNote: String?,
        recipient: String?,
        company: String?,
        phoneNumber: String?
    ) {
        self.title = title
        self.isDefault = isDefault
        self.addressType = addressType
        self.streetAddress = streetAddress
        self.locality = locality
        self.region = region
        self.postalCode = postalCode
        self.country = country
        self.raw = raw
        self.deliveryNote = deliveryNote
        self.recipient = recipient
        self.company = company
        self.phoneNumber = phoneNumber
    }

    public required init(map: Map) throws {
        title = try? map.value("title")
        isDefault = try? map.value("default")
        addressType = try? map.value("address_type")
        streetAddress = try? map.value("street_address")
        locality = try? map.value("locality")
        region = try? map.value("region")
        postalCode = try? map.value("postal_code")
        country = try? map.value("country")
        raw = try? map.value("raw")
        deliveryNote = try? map.value("delivery_note")
        recipient = try? map.value("recipient")
        company = try? map.value("company")
        phoneNumber = try? map.value("phone_number")
    }

    public func mapping(map: Map) {
        title >>> map["title"]
        isDefault >>> map["default"]
        addressType >>> map["address_type"]
        streetAddress >>> map["street_address"]
        locality >>> map["locality"]
        region >>> map["region"]
        postalCode >>> map["postal_code"]
        country >>> map["country"]
        raw >>> map["raw"]
        deliveryNote >>> map["delivery_note"]
        recipient >>> map["recipient"]
        company >>> map["company"]
        phoneNumber >>> map["phone_number"]
    }
    
    public override var description: String {
        return self.toJSONString(prettyPrint: true) ?? super.description
    }
}
