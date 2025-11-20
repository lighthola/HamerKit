import UIKit

@objc
public extension CALayer {
    @discardableResult func borderColor(_ color: CGColor) -> Self {
        self.borderColor = color; return self
    }
    
    @discardableResult func borderWidth(_ width: CGFloat) -> Self {
        self.borderWidth = width; return self
    }
    
    @discardableResult func cornerRadius(_ radius: CGFloat) -> Self {
        self.cornerRadius = radius; return self
    }
    
    @discardableResult func masksToBounds(_ enabled: Bool) -> Self {
        self.masksToBounds = enabled; return self
    }
}
