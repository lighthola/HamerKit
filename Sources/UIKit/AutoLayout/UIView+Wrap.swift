import UIKit

public extension UIView {
    
    func wrapView(inset: UIEdgeInsets) -> UIView {
        let view = UIView()
        view.addSubview(self)
        mLay(pin: inset)
        return view
    }
    
    func wrapViewCenterXY(width: CGFloat? = nil, height: CGFloat? = nil) -> UIView {
        let view = UIView()
        view.addSubview(self)
        if let width {
            view.mLay(.width, width)
        }
        if let height {
            view.mLay(.height, height)
        }
        mLayCenterXYFlexChain()
        return view
    }
    
    func wrapViewCenterX(top: CGFloat? = 0, bottom: CGFloat? = 0, width: CGFloat? = nil) -> UIView {
        let view = UIView()
        view.addSubview(self)
        if let top {
            mLay(pin: .top(top))
        }
        if let bottom {
            mLay(pin: .bottom(bottom))
        }
        if let width {
            view.mLay(.width, width)
        }
        mLayCenterXFlex()
        return view
    }
    
    func wrapViewCenterY(left: CGFloat? = 0, right: CGFloat? = 0, height: CGFloat? = nil) -> UIView {
        let view = UIView()
        view.addSubview(self)
        if let left {
            mLay(pin: .leading(left))
        }
        if let right {
            mLay(pin: .trailing(right))
        }
        if let height {
            view.mLay(.height, height)
        }
        mLayCenterYFlex()
        return view
    }
    
}
