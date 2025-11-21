import UIKit

public extension ButtonStateConfiguration {
    enum ButtonState: CaseIterable, Hashable {
        case normal, highlighted, selected, disabled, selectHighlighted
    }
    
    enum ButtonColor: Hashable {
        case color(UIColor)
        case gradient([UIColor],
                      start: CGPoint = .zero,
                      end: CGPoint = .init(x: 1, y: 0),
                      locations: [NSNumber] = [0, 1])
        case clear
    }
    
    enum EdgeInset: Hashable {
        case top(CGFloat), leading(CGFloat), bottom(CGFloat), trailing(CGFloat)
        case horizontal(CGFloat), vertical(CGFloat)
        case all(CGFloat)
    }
}

public struct ButtonStateConfiguration {
    public var title: [ButtonState: String] = [:]
    public var titleColor: [ButtonState: UIColor] = [:]
    public var underlineStyle: [ButtonState: NSUnderlineStyle] = [:]
    public var backgroundColor: [ButtonState: ButtonColor] = [:]
    public var font: [ButtonState: UIFont] = [:]
    public var image: [ButtonState: UIImage] = [:]
    public var imagePadding: [ButtonState: CGFloat] = [:]
    public var imagePlacement: [ButtonState: NSDirectionalRectEdge] = [:]
    public var borderColor: [ButtonState: UIColor] = [:]
    public var borderWidth: [ButtonState: CGFloat] = [:]
    public var cornerStyle: [ButtonState: UIButton.Configuration.CornerStyle] = [:]
    public var cornerRadius: [ButtonState: CGFloat] = [:]
    public var edgeInsets: [ButtonState: [EdgeInset]] = [:]
    
    public init() {}
    
    public init(_ config: UIButton.Configuration) {
        self.title[.normal] = config.title
        self.titleColor[.normal] = config.baseForegroundColor
        if let backgroundColor = config.baseBackgroundColor { self.backgroundColor[.normal] = .color(backgroundColor) }
        self.font[.normal] = config.attributedTitle?.font
        if config.attributedTitle?.underlineStyle != nil { self.underlineStyle[.normal] = .single }
        self.image[.normal] = config.image
        self.imagePadding[.normal] = config.imagePadding
        self.imagePlacement[.normal] = config.imagePlacement
        if config.background.strokeColor != .clear {
            self.borderColor[.normal] = config.background.strokeColor
            self.borderWidth[.normal] = config.background.strokeWidth
        }
        self.cornerStyle[.normal] = config.cornerStyle
        self.cornerRadius[.normal] = config.background.cornerRadius
        self.edgeInsets[.normal] = config.contentInsets.toButtonEdgeInsets()
    }
}

extension NSDirectionalEdgeInsets {
    func toButtonEdgeInsets() -> [AnimatedConfigurableButton.EdgeInset] {
        [.top(top), .leading(leading), .bottom(bottom), .trailing(trailing)]
    }
}

// MARK: - DSL Builder

public extension ButtonStateConfiguration {
    @discardableResult func title(_ text: String, for state: ButtonState = .normal) -> Self {
        var copy = self; copy.title[state] = text; return copy
    }
    
    @discardableResult func titleColor(_ color: UIColor?, for state: ButtonState = .normal) -> Self {
        var copy = self; copy.titleColor[state] = color; return copy
    }
    
    @discardableResult func background(_ color: ButtonColor?, for state: ButtonState = .normal) -> Self {
        var copy = self; copy.backgroundColor[state] = color; return copy
    }
    
    @discardableResult func font(_ font: UIFont, for state: ButtonState = .normal) -> Self {
        var copy = self; copy.font[state] = font; return copy
    }
    
    @discardableResult func isUnderlineEnabled(_ enabled: Bool, for state: ButtonState = .normal) -> Self {
        var copy = self; copy.underlineStyle[state] = enabled ? .single : nil; return copy
    }
    
    @discardableResult func image(_ image: UIImage?, for state: ButtonState = .normal) -> Self {
        var copy = self; copy.image[state] = image; return copy
    }
    
    @discardableResult func imagePadding(_ padding: CGFloat, for state: ButtonState = .normal) -> Self {
        var copy = self; copy.imagePadding[state] = padding; return copy
    }
    
    @discardableResult func imagePlacement(_ placement: NSDirectionalRectEdge, for state: ButtonState = .normal) -> Self {
        var copy = self; copy.imagePlacement[state] = placement; return copy
    }
    
    @discardableResult func border(color: UIColor?, width: CGFloat, for state: ButtonState = .normal) -> Self {
        var copy = self
        copy.borderColor[state] = color
        copy.borderWidth[state] = width
        return copy
    }
    
    @discardableResult func cornerStyle(_ style: UIButton.Configuration.CornerStyle, for state: ButtonState = .normal) -> Self {
        var copy = self; copy.cornerStyle[state] = style; return copy
    }
    
    @discardableResult func cornerRadius(_ radius: CGFloat, for state: ButtonState = .normal) -> Self {
        var copy = self; copy.cornerRadius[state] = radius; return copy
    }
    
    @discardableResult func edgeInsets(_ insets: [EdgeInset], for state: ButtonState = .normal) -> Self {
        var copy = self; copy.edgeInsets[state] = insets; return copy
    }
}
