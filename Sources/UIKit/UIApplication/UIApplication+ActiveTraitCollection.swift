import UIKit

public extension UIApplication {
    /** Attempts to return the active trait collection for the first window, or an empty trait collection otherwise. Because this specifically uses the first window for the trait collection, it should only be used for system-wide settings – dark mode, scale, etc.
     */
    static var activeTraitCollection: UITraitCollection {
        UIApplication
           .shared
           .connectedScenes
           .flatMap({ ($0 as? UIWindowScene)?.windows ?? [] })
           .filter({ $0.isKeyWindow })
           .first?
           .traitCollection
        ?? UITraitCollection()
    }
}
