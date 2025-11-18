import UIKit

extension UIGestureRecognizer {
    typealias Action = ((UIGestureRecognizer) -> ())
    
    private struct Keys {
        @MainActor static var actionKey: Void?
    }
    
    private var action: Action? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &Keys.actionKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            objc_getAssociatedObject(self, &Keys.actionKey) as? Action
        }
    }
    
    @objc func handleAction(recognizer: UIGestureRecognizer) {
        action?(recognizer)
    }
    
    convenience public init(_ action: @escaping ((UIGestureRecognizer) -> ())) {
        self.init()
        self.action = action
        self.addTarget(self, action: #selector(handleAction(recognizer:)))
    }
}
