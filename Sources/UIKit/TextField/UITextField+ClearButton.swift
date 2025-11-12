import UIKit

public extension UITextField {
    var clearButton: UIButton? {
        return value(forKey: "clearButton") as? UIButton
    }

    /// the color of clear button
    var clearButtonTintColor: UIColor? {
        get { clearButton?.tintColor }
        set {
            let image =  clearButton?
                .imageView?
                .image?
                .withRenderingMode(.alwaysTemplate)
            clearButton?.setImage(image, for: .normal)
            clearButton?.tintColor = newValue
        }
    }
}
