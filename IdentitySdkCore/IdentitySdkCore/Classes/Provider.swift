import Foundation
import UIKit

public protocol ProviderCreator {
    var name: String { get }
    func create(sdkConfig: SdkConfig) -> Provider
    
}

public protocol Provider {
    var name: String { get }
    func login(origin: String, viewController: UIViewController?)
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool
}
