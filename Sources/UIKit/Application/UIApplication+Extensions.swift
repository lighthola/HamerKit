import UIKit

public extension UIApplication {
    var keyWindow: UIWindow? {
        connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap(\.windows)
            .filter({ $0.isKeyWindow })
            .first
    }
    
    var windowSize: CGSize {
        keyWindow?.bounds.size ?? .zero
    }
    
    var topMostViewController: UIViewController? {
        keyWindow?.rootViewController?.topMostViewController()
    }
    
    // https://stackoverflow.com/questions/52402477/ios-detect-if-the-device-is-iphone-x-family-frameless
    var hasNotch: Bool {
        guard let keyWindow else { return false }
        
        if UIDevice.current.orientation.isPortrait || UIDevice.current.orientation == .unknown {
            return keyWindow.safeAreaInsets.top >= 44
        } else {
            return keyWindow.safeAreaInsets.left > 0 || keyWindow.safeAreaInsets.right > 0
        }
    }
    
    /// Attempts to return the active trait collection for the first window, or an empty trait collection otherwise.
    /// Because this specifically uses the first window for the trait collection, it should only be used for system-wide
    /// settings – dark mode, scale, etc.
    var activeTraitCollection: UITraitCollection {
        keyWindow?.traitCollection ?? UITraitCollection()
    }
}

// MARK: UIScreen

public extension UIApplication {
    var mainScreen: UIScreen? { keyWindow?.screen }
    
    /// 螢幕縮放比例
    var displayZoomRatio: CGFloat { mainScreen?.displayZoomRatio ?? 1.0 }
}
