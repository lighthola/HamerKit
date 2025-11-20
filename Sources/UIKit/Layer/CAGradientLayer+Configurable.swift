import UIKit

@objc
public extension CAGradientLayer {
    @discardableResult func colors(_ colors: [CGColor]) -> Self {
        self.colors = colors; return self
    }
    
    @discardableResult func startPoint(_ point: CGPoint) -> Self {
        self.startPoint = point; return self
    }
    
    @discardableResult func endPoint(_ point: CGPoint) -> Self {
        self.endPoint = point; return self
    }
    
    @discardableResult func locations(_ locations: [NSNumber]?) -> Self {
        self.locations = locations; return self
    }
}
