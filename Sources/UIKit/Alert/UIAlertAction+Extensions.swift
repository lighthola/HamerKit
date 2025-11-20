import UIKit

public extension UIAlertAction {
    convenience init(title: String) {
        self.init(title: title, style: .default, handler: nil)
    }
    
    convenience init(title: String, handler: @escaping (UIAlertAction) -> Void) {
        self.init(title: title, style: .default, handler: handler)
    }
}
