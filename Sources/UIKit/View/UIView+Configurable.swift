import UIKit

@objc
public extension UIView {
    @discardableResult func alpha(_ value: CGFloat) -> Self {
        self.alpha = value; return self
    }
    
    @discardableResult func backgroundColor(_ color: UIColor?) -> Self {
        self.backgroundColor = color; return self
    }
    
    @discardableResult func borderColor(_ color: UIColor?) -> Self {
        layer.borderColor = color?.cgColor; return self
    }
    
    @discardableResult func borderWidth(_ width: CGFloat) -> Self {
        layer.borderWidth = width; return self
    }
    
    @discardableResult func clipsToBounds(_ value: Bool) -> Self {
        self.clipsToBounds = value; return self
    }
    
    @discardableResult func contentMode(_ mode: ContentMode) -> Self {
        self.contentMode = mode; return self
    }
    
    @discardableResult func cornerRadius(_ radius: CGFloat) -> Self {
        layer.cornerRadius = radius; return self
    }
    
    @discardableResult func isHidden(_ value: Bool) -> Self {
        self.isHidden = value; return self
    }
    
    @discardableResult func isUserInteractionEnabled(_ value: Bool) -> Self {
        self.isUserInteractionEnabled = value; return self
    }
    
    @discardableResult func tag(_ value: Int) -> Self {
        self.tag = value; return self
    }
    
    @discardableResult func tintColor(_ color: UIColor) -> Self {
        self.tintColor = color; return self
    }
}
