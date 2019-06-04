import Foundation

public protocol Provider {
    var name: String { get }
}

public protocol ProviderCreator {
    var name: String { get }
    func create(sdkConfig: SdkConfig) -> Provider
}
