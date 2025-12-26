import Foundation

public struct RuntimeError: LocalizedError {
    public let message: String

    public var errorDescription: String? { message }
    
    public init(message: String) {
        self.message = message
    }
}
