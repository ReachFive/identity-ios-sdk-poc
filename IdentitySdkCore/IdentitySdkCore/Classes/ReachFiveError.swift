import Foundation

public enum ReachFiveError: Swift.Error {
    case AuthFailure(reason: String)
    case AuthCanceled
    case TechnicalError(reason: String)
}
