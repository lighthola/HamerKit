import UIKit

public struct SystemAlertOption: Sendable {
    public let action: UIAlertAction
    public var isPreferredAction: Bool = false
    
    public init(action: UIAlertAction, isPreferredAction: Bool = false) {
        self.action = action
        self.isPreferredAction = isPreferredAction
    }
}

public extension UIAlertAction {
    func toOption(isPreferredAction: Bool = false) -> SystemAlertOption {
        SystemAlertOption(action: self, isPreferredAction: isPreferredAction)
    }
}
