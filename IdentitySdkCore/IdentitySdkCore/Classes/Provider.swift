import Foundation
import UIKit

public protocol Provider {
    var name: String { get }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
}

public protocol ProviderCreator {
    var name: String { get }
    func create(sdkConfig: SdkConfig) -> Provider
}
