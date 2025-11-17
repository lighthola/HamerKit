import UIKit

public extension UIDevice {
    var hasNotch: Bool {
        UIApplication.shared.hasNotch
    }
}
