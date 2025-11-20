import UIKit

public extension UIAlertController {
    static func normal(title: String?, message: String, options: [SystemAlertOption]) -> UIAlertController {
        SystemAlert.normal(title: title, message: message, options: options).build()
    }
    
    static func attributed(title: NSAttributedString?, message: NSAttributedString, options: [SystemAlertOption]) -> UIAlertController {
        SystemAlert.attributed(title: title, message: message, options: options).build()
    }
}
