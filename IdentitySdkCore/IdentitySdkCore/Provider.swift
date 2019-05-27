import Foundation

public protocol Provider {
    func helloWorld() -> String
}

public protocol ProviderCreator {
    func create(sdkConfig: SdkConfig) -> Provider
}
