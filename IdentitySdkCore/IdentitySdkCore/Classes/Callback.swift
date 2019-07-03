import Foundation

public typealias Success<T> = (T) -> Void
public typealias Failure<E> = (E) -> Void

public typealias Callback<T> = (Result<T, ReachFiveError>) -> Void
