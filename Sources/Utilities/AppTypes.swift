import Foundation

// MARK: Closure - Void

/// A closure with no parameters and no return value
public typealias VoidHandler = () -> Void

/// A sendable closure with no parameters and no return value
public typealias SendableVoidHandler = @Sendable () -> Void

// MARK: Basic Types

/// A closure with a Bool parameter
public typealias BoolHandler = (Bool) -> Void

/// A sendable closure with a Bool parameter
public typealias SendableBoolHandler = @Sendable (Bool) -> Void

/// A closure with an Int parameter
public typealias IndexHandler = (Int) -> Void

/// A sendable closure with an Int parameter
public typealias SendableIndexHandler = @Sendable (Int) -> Void

/// A closure with an IndexPath parameter
public typealias IndexPathHandler = (IndexPath) -> Void

/// A sendable closure with an IndexPath parameter
public typealias SendableIndexPathHandler = @Sendable (IndexPath) -> Void

/// A closure with an Error parameter
public typealias ErrorHandler = (Error) -> Void

/// A sendable closure with an Error parameter
public typealias SendableErrorHandler = @Sendable (Error) -> Void

// MARK: Generic Types

/// A closure with a generic parameter
public typealias ValueHandler<T> = (T) -> Void

/// A closure with a generic parameter
public typealias SendableValueHandler<T> = @Sendable (T) -> Void

/// A closure that returns a Result<T, Error>
public typealias ResultHandler<T> = (Result<T, Error>) -> Void

/// A closure that returns a Result<T, Error>
public typealias SendableResultHandler<T> = @Sendable (Result<T, Error>) -> Void

// MARK: -
