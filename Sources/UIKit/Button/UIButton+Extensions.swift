import UIKit

public extension UIButton {
    func toBarButtonItem()  -> UIBarButtonItem { UIBarButtonItem(customView: self) }
}
