import UIKit

public extension UITabBarController {
    override func topMostViewController() -> UIViewController {
        selectedViewController?.topMostViewController() ?? self
    }
}

public extension UINavigationController {
    override func topMostViewController() -> UIViewController {
        visibleViewController?.topMostViewController() ?? self
    }
}

extension UIViewController {
    @objc open func topMostViewController() -> UIViewController {
        if let presentedViewController = self.presentedViewController {
            // Handling Modal views
            return presentedViewController.topMostViewController()
        }
        else {
            // Handling UIViewController's added as subviews to some other views.
            for view in self.view.subviews  {
                // Key property which most of us are unaware of / rarely use.
                if let subViewController = view.next {
                    if subViewController is UIViewController {
                        let viewController = subViewController as! UIViewController
                        return viewController.topMostViewController()
                    }
                }
            }
            
            return self
        }
    }
}
