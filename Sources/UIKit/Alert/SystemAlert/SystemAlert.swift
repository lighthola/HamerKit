import UIKit

@MainActor
public enum SystemAlert {
    case normal(title: String?, message: String, options: [SystemAlertOption])
    case attributed(title: NSAttributedString?, message: NSAttributedString, options: [SystemAlertOption])
    
    public func build() -> UIAlertController {
        switch self {
        case let .normal(title, message, options):
            SystemAlert.buildAlert(title: title, message: message, options: options)
        case let .attributed(title, message, options):
            SystemAlert.buildAlert(attributedTitle: title, attributedMessage: message, options: options)
        }
    }
    
    public func show(on presenting: UIViewController?, animated: Bool = true, completion: SendableVoidHandler?) {
        let alertViewController = build()
        presenting?.present(alertViewController, animated: animated, completion: completion)
    }
    
    // MARK: Static
    
    public static func buildAlert(title: String?, message: String, options: [SystemAlertOption]) -> UIAlertController {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        addActions(options, to: alertViewController)
        return alertViewController
    }
    
    public static func buildAlert(attributedTitle: NSAttributedString?, attributedMessage: NSAttributedString, options: [SystemAlertOption]) -> UIAlertController {
        let alertViewController = UIAlertController(title: attributedTitle?.string, message: attributedMessage.string, preferredStyle: .alert)
        if let attributedTitle { alertViewController.setValue(attributedTitle, forKey: "attributedTitle") }
        alertViewController.setValue(attributedMessage, forKey: "attributedMessage")
        addActions(options, to: alertViewController)
        return alertViewController
    }
    
    // MARK: Private
    
    private static func addActions(_ options: [SystemAlertOption], to alert: UIAlertController) {
        for option in options {
            alert.addAction(option.action)
            
            if option.isPreferredAction {
                alert.preferredAction = option.action
            }
        }
    }
}
