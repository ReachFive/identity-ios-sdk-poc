import Foundation

public protocol ReachFiveDelegate {
    func authentication(result: Result<String, ReachFiveError>)
}
