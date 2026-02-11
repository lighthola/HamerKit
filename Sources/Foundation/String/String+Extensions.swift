import Foundation

public extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}

public extension String {
    func withDefault(_ defaultValue: String) -> String {
        isEmpty ? defaultValue : self
    }
}

public extension Optional where Wrapped == String {
    func orDefault(_ defaultValue: String) -> String {
        switch self {
        case .none:
            defaultValue
        case .some(let wrapped):
            wrapped.withDefault(defaultValue)
        }
    }
    
    var isEmpty: Bool {
        switch self {
        case .none: true
        case .some(let wrapped): wrapped.isEmpty
        }
    }
}
