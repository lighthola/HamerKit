//
//  https://gist.github.com/nick6969/62ca2c7fef0a6113cd9356d2424a4522
//

import UIKit

extension UIView {
    public struct OptionalEdge {
        var top: CGFloat?
        var leading: CGFloat?
        var bottom: CGFloat?
        var trailing: CGFloat?
        
        private init(top: CGFloat? = nil, leading: CGFloat? = nil, bottom: CGFloat? = nil, trailing: CGFloat? = nil) {
            self.top = top
            self.leading = leading
            self.bottom = bottom
            self.trailing = trailing
        }
        
        public static func all(_ value: CGFloat = 0) -> UIView.OptionalEdge {
            .init(top: value, leading: value, bottom: value, trailing: value)
        }
        
        public static func vertical(_ value: CGFloat = 0) -> UIView.OptionalEdge {
            .init(top: value, bottom: value)
        }
        
        public static func horizontal(_ value: CGFloat = 0) -> UIView.OptionalEdge {
            .init(leading: value, trailing: value)
        }
        
        public static func top(_ value: CGFloat = 0) -> UIView.OptionalEdge {
            .init(top: value)
        }
        
        public static func bottom(_ value: CGFloat = 0) -> UIView.OptionalEdge {
            .init(bottom: value)
        }
        
        public static func leading(_ value: CGFloat = 0) -> UIView.OptionalEdge {
            .init(leading: value)
        }
        
        public static func trailing(_ value: CGFloat = 0) -> UIView.OptionalEdge {
            .init(trailing: value)
        }
        
        public func vertical(_ value: CGFloat = 0) -> UIView.OptionalEdge {
            var new: UIView.OptionalEdge = self
            new.top = value
            new.bottom = value
            return new
        }
        
        public func horizontal(_ value: CGFloat = 0) -> UIView.OptionalEdge {
            var new: UIView.OptionalEdge = self
            new.leading = value
            new.trailing = value
            return new
        }
        
        public func top(_ value: CGFloat = 0) -> UIView.OptionalEdge {
            var new: UIView.OptionalEdge = self
            new.top = value
            return new
        }
        
        public func bottom(_ value: CGFloat = 0) -> UIView.OptionalEdge {
            var new: UIView.OptionalEdge = self
            new.bottom = value
            return new
        }
        
        public func leading(_ value: CGFloat = 0) -> UIView.OptionalEdge {
            var new: UIView.OptionalEdge = self
            new.leading = value
            return new
        }
        
        public func trailing(_ value: CGFloat = 0) -> UIView.OptionalEdge {
            var new: UIView.OptionalEdge = self
            new.trailing = value
            return new
        }
    }
}

public extension UIView {
    @discardableResult
    func mLay(_ attribute: NSLayoutConstraint.Attribute,
              _ relatedBy: NSLayoutConstraint.Relation,
              _ toItem: UIView?,
              _ attribute1: NSLayoutConstraint.Attribute,
              multiplier: CGFloat,
              constant: CGFloat,
              active: Bool = true,
              priority: UILayoutPriority = .required,
              file: String = #file,
              line: Int = #line) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint: NSLayoutConstraint = NSLayoutConstraint(item: self,
                                                                attribute: attribute,
                                                                relatedBy: relatedBy,
                                                                toItem: toItem,
                                                                attribute: attribute1,
                                                                multiplier: multiplier,
                                                                constant: constant)
        constraint.priority = priority
        constraint.isActive = active
        constraint.identifier = file.components(separatedBy: "/").last! + ":\(line)"
        return constraint
    }
    
    @discardableResult
    func mLay(_ attribute: NSLayoutConstraint.Attribute,
              _ relatedBy: NSLayoutConstraint.Relation,
              _ toItem: UIView?,
              active: Bool = true,
              priority: UILayoutPriority = .required,
              file: String = #file,
              line: Int = #line) -> NSLayoutConstraint {
        mLay(attribute, relatedBy, toItem, attribute, multiplier: 1, constant: 0, active: active, priority: priority, file: file, line: line)
    }
    
    @discardableResult
    func mLay(_ attribute: NSLayoutConstraint.Attribute,
              _ constant: CGFloat,
              active: Bool = true,
              priority: UILayoutPriority = .required,
              file: String = #file,
              line: Int = #line) -> NSLayoutConstraint {
        mLay(attribute, .equal, nil, attribute, multiplier: 1, constant: constant, active: active, priority: priority, file: file, line: line)
    }
    
    @discardableResult
    func mLay(_ attribute: NSLayoutConstraint.Attribute,
              _ relatedBy: NSLayoutConstraint.Relation,
              _ toItem: UIView?,
              multiplier: CGFloat,
              constant: CGFloat = 0,
              active: Bool = true,
              priority: UILayoutPriority = .required,
              file: String = #file,
              line: Int = #line) -> NSLayoutConstraint {
        mLay(attribute, relatedBy, toItem, attribute, multiplier: multiplier, constant: constant, active: active, priority: priority, file: file, line: line)
    }
    
    @discardableResult
    func mLay(_ attribute: NSLayoutConstraint.Attribute,
              _ relatedBy: NSLayoutConstraint.Relation,
              _ toItem: UIView?,
              constant: CGFloat,
              active: Bool = true,
              priority: UILayoutPriority = .required,
              file: String = #file,
              line: Int = #line) -> NSLayoutConstraint {
        mLay(attribute, relatedBy, toItem, attribute, multiplier: 1, constant: constant, active: active, priority: priority, file: file, line: line)
    }
    
    @discardableResult
    func mLay(_ attribute: NSLayoutConstraint.Attribute,
              _ relatedBy: NSLayoutConstraint.Relation,
              _ toItem: UIView?,
              _ attribute1: NSLayoutConstraint.Attribute,
              constant: CGFloat = 0,
              active: Bool = true,
              priority: UILayoutPriority = .required,
              file: String = #file,
              line: Int = #line) -> NSLayoutConstraint {
        mLay(attribute, relatedBy, toItem, attribute1, multiplier: 1, constant: constant, active: active, priority: priority, file: file, line: line)
    }
    
    @discardableResult
    func mLay(pin: UIEdgeInsets, to view: UIView? = nil, file: String = #file, line: Int = #line) -> [NSLayoutConstraint] {
        assert(view != nil || superview != nil, "can't add Constraint to nil , superview and parameter view is nil")
        let view: UIView = view ?? superview!
        return [
            mLay(.top, .equal, view, constant: pin.top, file: file, line: line),
            mLay(.left, .equal, view, constant: pin.left, file: file, line: line),
            mLay(.bottom, .equal, view, constant: -pin.bottom, file: file, line: line),
            mLay(.right, .equal, view, constant: -pin.right, file: file, line: line)
        ]
    }
    
    @discardableResult
    func mLayEqualSuper(file: String = #file, line: Int = #line) -> [NSLayoutConstraint] {
        mLay(pin: .zero, file: file, line: line)
    }
    
    @discardableResult
    func mLay(pin: OptionalEdge, to view: UIView? = nil, priority: UILayoutPriority = .required, file: String = #file, line: Int = #line) -> [NSLayoutConstraint] {
        assert(view != nil || superview != nil, "can't add Constraint to nil , superview and parameter view is nil")
        var arr: [NSLayoutConstraint] = []
        let view: UIView = view ?? superview!
        if let top: CGFloat = pin.top { arr.append(mLay(.top, .equal, view, constant: top, priority: priority, file: file, line: line)) }
        if let leading: CGFloat = pin.leading { arr.append(mLay(.leading, .equal, view, constant: leading, priority: priority, file: file, line: line)) }
        if let bottom: CGFloat = pin.bottom { arr.append(mLay(.bottom, .equal, view, constant: -bottom, priority: priority, file: file, line: line)) }
        if let trailing: CGFloat = pin.trailing { arr.append(mLay(.trailing, .equal, view, constant: -trailing, priority: priority, file: file, line: line)) }
        return arr
    }
    
    @discardableResult
    func mLayCenterXY(to view: UIView? = nil, file: String = #file, line: Int = #line) -> [NSLayoutConstraint] {
        assert(view != nil || superview != nil, "can't add Constraint to nil , superview and parameter view is nil")
        return [mLay(.centerY, .equal, view ?? superview!, file: file, line: line),
                mLay(.centerX, .equal, view ?? superview!, file: file, line: line)]
    }
    
    @discardableResult
    func mLayCenterX(to view: UIView? = nil, file: String = #file, line: Int = #line) -> NSLayoutConstraint {
        assert(view != nil || superview != nil, "can't add Constraint to nil , superview and parameter view is nil")
        return mLay(.centerX, .equal, view ?? superview!, file: file, line: line)
    }
    
    @discardableResult
    func mLayCenterY(to view: UIView? = nil, file: String = #file, line: Int = #line) -> NSLayoutConstraint {
        assert(view != nil || superview != nil, "can't add Constraint to nil , superview and parameter view is nil")
        return mLay(.centerY, .equal, view ?? superview!, file: file, line: line)
    }
    
    @discardableResult
    func mLay(size: CGSize, file: String = #file, line: Int = #line) -> [NSLayoutConstraint] {
        [mLay(width: size.width, file: file, line: line), mLay(height: size.height, file: file, line: line)]
    }
    
    @discardableResult
    func mLay(width: CGFloat, file: String = #file, line: Int = #line) -> NSLayoutConstraint {
        mLay(.width, width, file: file, line: line)
    }
    
    @discardableResult
    func mLay(height: CGFloat, file: String = #file, line: Int = #line) -> NSLayoutConstraint {
        mLay(.height, height, file: file, line: line)
    }
    
    @discardableResult
    func mLayFlex(pin: UIEdgeInsets, to view: UIView? = nil, file: String = #file, line: Int = #line) -> [NSLayoutConstraint] {
        assert(view != nil || superview != nil, "can't add Constraint to nil , superview and parameter view is nil")
        let view: UIView = view ?? superview!
        return [
            mLay(.top, .greaterThanOrEqual, view, constant: pin.top, file: file, line: line),
            mLay(.left, .greaterThanOrEqual, view, constant: pin.left, file: file, line: line),
            mLay(.bottom, .lessThanOrEqual, view, constant: -pin.bottom, file: file, line: line),
            mLay(.right, .lessThanOrEqual, view, constant: -pin.right, file: file, line: line)
        ]
    }
    
    @discardableResult
    func mLayFlex(pin: OptionalEdge, to view: UIView? = nil, file: String = #file, line: Int = #line) -> [NSLayoutConstraint] {
        assert(view != nil || superview != nil, "can't add Constraint to nil , superview and parameter view is nil")
        var arr: [NSLayoutConstraint] = []
        let view: UIView = view ?? superview!
        if let top: CGFloat = pin.top { arr.append(mLay(.top, .greaterThanOrEqual, view, constant: top, file: file, line: line)) }
        if let leading: CGFloat = pin.leading { arr.append(mLay(.leading, .greaterThanOrEqual, view, constant: leading, file: file, line: line)) }
        if let bottom: CGFloat = pin.bottom { arr.append(mLay(.bottom, .lessThanOrEqual, view, constant: -bottom, file: file, line: line)) }
        if let trailing: CGFloat = pin.trailing { arr.append(mLay(.trailing, .lessThanOrEqual, view, constant: -trailing, file: file, line: line)) }
        return arr
    }
    
    @discardableResult
    func mLayCenterXYFlex(to view: UIView? = nil, file: String = #file, line: Int = #line) -> [NSLayoutConstraint] {
        assert(view != nil || superview != nil, "can't add Constraint to nil , superview and parameter view is nil")
        return mLayCenterXY(to: view, file: file, line: line) + mLayFlex(pin: .all(), to: view, file: file, line: line)
    }
    
    @discardableResult
    func mLayCenterXFlex(to view: UIView? = nil, file: String = #file, line: Int = #line) -> [NSLayoutConstraint] {
        assert(view != nil || superview != nil, "can't add Constraint to nil , superview and parameter view is nil")
        return [mLayCenterX(to: view, file: file, line: line)] + mLayFlex(pin: .horizontal(), to: view, file: file, line: line)
    }
    
    @discardableResult
    func mLayCenterYFlex(to view: UIView? = nil, file: String = #file, line: Int = #line) -> [NSLayoutConstraint] {
        assert(view != nil || superview != nil, "can't add Constraint to nil , superview and parameter view is nil")
        return [mLayCenterY(to: view, file: file, line: line)] + mLayFlex(pin: .vertical(), to: view, file: file, line: line)
    }
}

public extension UIView {
    enum LayoutDirection {
        case top
        case trailing
        case bottom
        case leading
    }
    
    @discardableResult
    func mLaySafe(_ direction: LayoutDirection,
                  _ relatedBy: NSLayoutConstraint.Relation = .equal,
                  _ to: UIView? = nil,
                  _ direction1: LayoutDirection? = nil,
                  constant: CGFloat = 0,
                  active: Bool = true,
                  priority: UILayoutPriority = .required,
                  file: String = #file,
                  line: Int = #line) -> NSLayoutConstraint {
        assert(to != nil || superview != nil, "can't add Constraint to nil , superview and parameter view is nil")
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let toViewGuide: UILayoutGuide = (to ?? superview!).safeAreaLayoutGuide
        let toDirection: LayoutDirection = direction1 ?? direction
        var constraint: NSLayoutConstraint
        
        switch (direction, toDirection, relatedBy) {
        case (.top, .top, .equal): constraint = topAnchor.constraint(equalTo: toViewGuide.topAnchor)
        case (.top, .top, .greaterThanOrEqual): constraint = topAnchor.constraint(greaterThanOrEqualTo: toViewGuide.topAnchor)
        case (.top, .top, .lessThanOrEqual): constraint = topAnchor.constraint(lessThanOrEqualTo: toViewGuide.topAnchor)
            
        case (.top, .bottom, .equal): constraint = topAnchor.constraint(equalTo: toViewGuide.bottomAnchor)
        case (.top, .bottom, .greaterThanOrEqual): constraint = topAnchor.constraint(greaterThanOrEqualTo: toViewGuide.bottomAnchor)
        case (.top, .bottom, .lessThanOrEqual): constraint = topAnchor.constraint(lessThanOrEqualTo: toViewGuide.bottomAnchor)
            
        case (.leading, .leading, .equal): constraint = leadingAnchor.constraint(equalTo: toViewGuide.leadingAnchor)
        case (.leading, .leading, .greaterThanOrEqual): constraint = leadingAnchor.constraint(greaterThanOrEqualTo: toViewGuide.leadingAnchor)
        case (.leading, .leading, .lessThanOrEqual): constraint = leadingAnchor.constraint(lessThanOrEqualTo: toViewGuide.leadingAnchor)
            
        case (.leading, .trailing, .equal): constraint = leadingAnchor.constraint(equalTo: toViewGuide.trailingAnchor)
        case (.leading, .trailing, .greaterThanOrEqual): constraint = leadingAnchor.constraint(greaterThanOrEqualTo: toViewGuide.trailingAnchor)
        case (.leading, .trailing, .lessThanOrEqual): constraint = leadingAnchor.constraint(lessThanOrEqualTo: toViewGuide.trailingAnchor)
            
        case (.bottom, .top, .equal): constraint = bottomAnchor.constraint(equalTo: toViewGuide.topAnchor)
        case (.bottom, .top, .greaterThanOrEqual): constraint = bottomAnchor.constraint(greaterThanOrEqualTo: toViewGuide.topAnchor)
        case (.bottom, .top, .lessThanOrEqual): constraint = bottomAnchor.constraint(lessThanOrEqualTo: toViewGuide.topAnchor)
            
        case (.bottom, .bottom, .equal): constraint = bottomAnchor.constraint(equalTo: toViewGuide.bottomAnchor)
        case (.bottom, .bottom, .greaterThanOrEqual): constraint = bottomAnchor.constraint(greaterThanOrEqualTo: toViewGuide.bottomAnchor)
        case (.bottom, .bottom, .lessThanOrEqual): constraint = bottomAnchor.constraint(lessThanOrEqualTo: toViewGuide.bottomAnchor)
            
        case (.trailing, .leading, .equal): constraint = trailingAnchor.constraint(equalTo: toViewGuide.leadingAnchor)
        case (.trailing, .leading, .greaterThanOrEqual): constraint = trailingAnchor.constraint(greaterThanOrEqualTo: toViewGuide.leadingAnchor)
        case (.trailing, .leading, .lessThanOrEqual): constraint = trailingAnchor.constraint(lessThanOrEqualTo: toViewGuide.leadingAnchor)
            
        case (.trailing, .trailing, .equal): constraint = trailingAnchor.constraint(equalTo: toViewGuide.trailingAnchor)
        case (.trailing, .trailing, .greaterThanOrEqual): constraint = trailingAnchor.constraint(greaterThanOrEqualTo: toViewGuide.trailingAnchor)
        case (.trailing, .trailing, .lessThanOrEqual): constraint = trailingAnchor.constraint(lessThanOrEqualTo: toViewGuide.trailingAnchor)
            
        default:
            fatalError("can't using `XAxisAnchor to YAxisAnchor` or `YAxisAnchor to XAxisAnchor`")
        }
        
        constraint.constant = constant
        constraint.active(bool: active)
        constraint.identifier = file.components(separatedBy: "/").last! + ":\(line)"
        constraint.priority = priority
        return constraint
    }
    
    @discardableResult
    func mLaySafe(pin: OptionalEdge, to view: UIView? = nil, priority: UILayoutPriority = .required, file: String = #file, line: Int = #line) -> [NSLayoutConstraint] {
        assert(view != nil || superview != nil, "can't add Constraint to nil , superview and parameter view is nil")
        var arr: [NSLayoutConstraint] = []
        let view: UIView = view ?? superview!
        if let value: CGFloat = pin.top { arr.append(mLaySafe(.top, .equal, view, constant: value, priority: priority, file: file, line: line)) }
        if let value: CGFloat = pin.leading { arr.append(mLaySafe(.leading, .equal, view, constant: value, priority: priority, file: file, line: line)) }
        if let value: CGFloat = pin.bottom { arr.append(mLaySafe(.bottom, .equal, view, constant: -value, priority: priority, file: file, line: line)) }
        if let value: CGFloat = pin.trailing { arr.append(mLaySafe(.trailing, .equal, view, constant: -value, priority: priority, file: file, line: line)) }
        return arr
    }
}

extension NSLayoutConstraint {
    @discardableResult
    func active(bool: Bool) -> NSLayoutConstraint {
        isActive = bool
        return self
    }
}

public extension UIView {
    @discardableResult
    func mLayChain(_ attribute: NSLayoutConstraint.Attribute,
                   _ relatedBy: NSLayoutConstraint.Relation,
                   _ toItem: UIView?,
                   _ attribute1: NSLayoutConstraint.Attribute,
                   multiplier: CGFloat,
                   constant: CGFloat,
                   active: Bool = true,
                   priority: UILayoutPriority = .required,
                   file: String = #file,
                   line: Int = #line) -> Self {
        mLay(attribute, relatedBy, toItem, attribute1, multiplier: multiplier, constant: constant, active: active, priority: priority, file: file, line: line)
        return self
    }
    
    @discardableResult
    func mLayChain(_ attribute: NSLayoutConstraint.Attribute,
                   _ relatedBy: NSLayoutConstraint.Relation,
                   _ toItem: UIView?,
                   active: Bool = true,
                   priority: UILayoutPriority = .required,
                   file: String = #file,
                   line: Int = #line) -> Self {
        mLay(attribute, relatedBy, toItem, attribute, multiplier: 1, constant: 0, active: active, priority: priority, file: file, line: line)
        return self
    }
    
    @discardableResult
    func mLayChain(_ attribute: NSLayoutConstraint.Attribute,
                   _ constant: CGFloat,
                   active: Bool = true,
                   priority: UILayoutPriority = .required,
                   file: String = #file,
                   line: Int = #line) -> Self {
        mLay(attribute, .equal, nil, attribute, multiplier: 1, constant: constant, active: active, priority: priority, file: file, line: line)
        return self
    }
    
    @discardableResult
    func mLayChain(_ attribute: NSLayoutConstraint.Attribute,
                   _ relatedBy: NSLayoutConstraint.Relation,
                   _ toItem: UIView?,
                   multiplier: CGFloat,
                   constant: CGFloat = 0,
                   active: Bool = true,
                   priority: UILayoutPriority = .required,
                   file: String = #file,
                   line: Int = #line) -> Self {
        mLay(attribute, relatedBy, toItem, attribute, multiplier: multiplier, constant: constant, active: active, priority: priority, file: file, line: line)
        return self
    }
    
    @discardableResult
    func mLayChain(_ attribute: NSLayoutConstraint.Attribute,
                   _ relatedBy: NSLayoutConstraint.Relation,
                   _ toItem: UIView?,
                   constant: CGFloat,
                   active: Bool = true,
                   priority: UILayoutPriority = .required,
                   file: String = #file,
                   line: Int = #line) -> Self {
        mLay(attribute, relatedBy, toItem, attribute, multiplier: 1, constant: constant, active: active, priority: priority, file: file, line: line)
        return self
    }
    
    @discardableResult
    func mLayChain(_ attribute: NSLayoutConstraint.Attribute,
                   _ relatedBy: NSLayoutConstraint.Relation,
                   _ toItem: UIView?,
                   _ attribute1: NSLayoutConstraint.Attribute,
                   constant: CGFloat = 0,
                   active: Bool = true,
                   priority: UILayoutPriority = .required,
                   file: String = #file,
                   line: Int = #line) -> Self {
        mLay(attribute, relatedBy, toItem, attribute1, multiplier: 1, constant: constant, active: active, priority: priority, file: file, line: line)
        return self
    }
    
    @discardableResult
    func mLayChain(pin: UIEdgeInsets, to view: UIView? = nil, file: String = #file, line: Int = #line) -> Self {
        mLay(pin: pin, to: view, file: file, line: line)
        return self
    }
    
    @discardableResult
    func mLayChainEqualSuper(file: String = #file, line: Int = #line) -> Self {
        mLayEqualSuper(file: file, line: line)
        return self
    }
    
    @discardableResult
    func mLayChain(pin: OptionalEdge, to view: UIView? = nil, priority: UILayoutPriority = .required, file: String = #file, line: Int = #line) -> Self {
        mLay(pin: pin, to: view, priority: priority, file: file, line: line)
        return self
    }
    
    @discardableResult
    func mLayChainCenterXY(to view: UIView? = nil, file: String = #file, line: Int = #line) -> Self {
        mLayCenterXY(to: view, file: file, line: line)
        return self
    }
    
    @discardableResult
    func mLayChainCenterX(to view: UIView? = nil, file: String = #file, line: Int = #line) -> Self {
        mLayCenterX(to: view, file: file, line: line)
        return self
    }
    
    @discardableResult
    func mLayChainCenterY(to view: UIView? = nil, file: String = #file, line: Int = #line) -> Self {
        mLayCenterY(to: view, file: file, line: line)
        return self
    }
    
    @discardableResult
    func mLayChain(size: CGSize, file: String = #file, line: Int = #line) -> Self {
        mLay(size: size, file: file, line: line)
        return self
    }
    
    @discardableResult
    func mLayChain(width: CGFloat, file: String = #file, line: Int = #line) -> Self {
        mLay(width: width, file: file, line: line)
        return self
    }
    
    @discardableResult
    func mLayChain(height: CGFloat, file: String = #file, line: Int = #line) -> Self {
        mLay(height: height, file: file, line: line)
        return self
    }
    
    @discardableResult
    func mLayFlexChain(pin: UIEdgeInsets, to view: UIView? = nil, file: String = #file, line: Int = #line) -> Self {
        mLayFlex(pin: pin, to: view, file: file, line: line)
        return self
    }
    
    @discardableResult
    func mLayFlexChain(pin: OptionalEdge, to view: UIView? = nil, file: String = #file, line: Int = #line) -> Self {
        mLayFlex(pin: pin, to: view, file: file, line: line)
        return self
    }
    
    @discardableResult
    func mLayCenterXYFlexChain(to view: UIView? = nil, file: String = #file, line: Int = #line) -> Self {
        mLayCenterXYFlex(to: view, file: file, line: line)
        return self
    }
    
    @discardableResult
    func mLayCenterXFlexChain(to view: UIView? = nil, file: String = #file, line: Int = #line) -> Self {
        mLayCenterXFlex(to: view, file: file, line: line)
        return self
    }
    
    @discardableResult
    func mLayCenterYFlexChain(to view: UIView? = nil, file: String = #file, line: Int = #line) -> Self {
        mLayCenterYFlex(to: view, file: file, line: line)
        return self
    }
}

public extension UIView {
    @discardableResult
    func mLayChainSafe(_ direction: LayoutDirection,
                       _ relatedBy: NSLayoutConstraint.Relation = .equal,
                       _ to: UIView? = nil,
                       _ direction1: LayoutDirection? = nil,
                       constant: CGFloat = 0,
                       active: Bool = true,
                       priority: UILayoutPriority = .required,
                       file: String = #file,
                       line: Int = #line) -> Self {
        mLaySafe(direction, relatedBy, to, direction1, constant: constant, active: active, priority: priority, file: file, line: line)
        return self
    }
    
    @discardableResult
    func mLayChainSafe(pin: OptionalEdge, to view: UIView? = nil, priority: UILayoutPriority = .required, file: String = #file, line: Int = #line) -> Self {
        mLaySafe(pin: pin, to: view, priority: priority, file: file, line: line)
        return self
    }
}
