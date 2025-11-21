import UIKit

public extension AnimatedConfigurableButton {
    static var clearButton: AnimatedConfigurableButton {
        AnimatedConfigurableButton()
            .title("")
            .background(.clear)
            .edgeInsets(.zero)
            .cornerStyle(.fixed)
            .cornerRadius(0)
    }
    
    static var toggleButton: AnimatedConfigurableButton {
        AnimatedConfigurableButton
            .clearButton
            .changesSelectionAsPrimaryAction(true)
    }
    
    static var underlineButton: AnimatedConfigurableButton {
        AnimatedConfigurableButton
            .clearButton
            .isUnderlineEnabled(true)
    }
}

public extension AnimatedConfigurableButton {
    enum ColorAdjustment {
        case alpha(CGFloat)        // 改變透明度
        case brighten(CGFloat)     // 提亮
        case darken(CGFloat)       // 變暗
        case desaturate(CGFloat)   // 降低飽和度
    }
}

public final class AnimatedConfigurableButton: UIButton {
    public typealias ButtonState = ButtonStateConfiguration.ButtonState
    public typealias ButtonColor = ButtonStateConfiguration.ButtonColor
    public typealias EdgeInset = ButtonStateConfiguration.EdgeInset
    
    public var stateConfiguration: ButtonStateConfiguration = .init()
    
    public private(set) var colorAdjustmentsByState: [ButtonState: [ColorAdjustment]] = [
        .highlighted: [.darken(0.05)],
        .selectHighlighted: [.darken(0.05)],
        .selected: [.brighten(0.1)],
        .disabled: [.desaturate(0.1), .alpha(0.5)]
    ]
    public var isColorAdjustmentEnabled: Bool = true
    
    public var isAnimationEnabled: Bool = true
    public var animationDuration: TimeInterval = 0.2
    
    public var buttonState: ButtonState { state.toButtonState() }
    
    public override class var layerClass: AnyClass { CAGradientLayer.self }
    private var gradientLayer: CAGradientLayer { layer as! CAGradientLayer }
    
    // MARK: - Init
    
    public init(_ configuration: UIButton.Configuration = .filled()) {
        super.init(frame: .zero)
        self.configuration = configuration
        applyStateConfiguration(ButtonStateConfiguration(configuration))
        
        configurationUpdateHandler = { [weak self] button in
            guard let self else { return }
            applyConfiguration(to: button, animated: isAnimationEnabled)
        }
    }
    
    public convenience init(_ configuration: ButtonStateConfiguration) {
        self.init(.filled())
        applyStateConfiguration(configuration)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    // MARK: Lifecycle
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        adjustGradientLayerIfNeeded(for: configuration)
    }
    
    // MARK: - Public
    
    public func applyStateConfiguration(_ config: ButtonStateConfiguration? = nil) {
        if let config { stateConfiguration = config }
        applyConfiguration(to: self, animated: false)
    }
    
    public func setTitle(_ title: String?, for state: ButtonState) {
        stateConfiguration.title[state] = title
        applyConfiguration(to: self, animated: false)
    }
    
    public func setTitleColor(_ color: UIColor?, for state: ButtonState) {
        stateConfiguration.titleColor[state] = color
        applyConfiguration(to: self, animated: false)
    }
    
    public func setBackgroundColor(_ color: ButtonColor?, for state: ButtonState) {
        stateConfiguration.backgroundColor[state] = color
        applyConfiguration(to: self, animated: false)
    }
    
    public func setFont(_ font: UIFont?, for state: ButtonState) {
        stateConfiguration.font[state] = font
        applyConfiguration(to: self, animated: false)
    }
    
    public func setUnderlineEnabled(_ enabled: Bool, for state: ButtonState) {
        stateConfiguration.underlineStyle[state] = enabled ? .single : nil
        applyConfiguration(to: self, animated: false)
    }
    
    public func setImage(_ image: UIImage?, for state: ButtonState) {
        stateConfiguration.image[state] = image
        applyConfiguration(to: self, animated: false)
    }
    
    public func setImagePadding(_ padding: CGFloat, for state: ButtonState) {
        stateConfiguration.imagePadding[state] = padding
        applyConfiguration(to: self, animated: false)
    }
    
    public func setImagePlacement(_ placement: NSDirectionalRectEdge, for state: ButtonState) {
        stateConfiguration.imagePlacement[state] = placement
        applyConfiguration(to: self, animated: false)
    }
    
    public func setBorderColor(_ color: UIColor?, for state: ButtonState) {
        stateConfiguration.borderColor[state] = color
        applyConfiguration(to: self, animated: false)
    }
    
    public func setBorderWidth(_ width: CGFloat, for state: ButtonState) {
        stateConfiguration.borderWidth[state] = width
        applyConfiguration(to: self, animated: false)
    }
    
    public func setCornerStyle(_ style: UIButton.Configuration.CornerStyle, for state: ButtonState) {
        stateConfiguration.cornerStyle[state] = style
        applyConfiguration(to: self, animated: false)
    }
    
    public func setCornerRadius(_ radius: CGFloat, for state: ButtonState) {
        stateConfiguration.cornerRadius[state] = radius
        applyConfiguration(to: self, animated: false)
    }
    
    public func setEdgeInsets(_ insets: [EdgeInset], for state: ButtonState) {
        stateConfiguration.edgeInsets[state] = insets
        applyConfiguration(to: self, animated: false)
    }
    
    public func setEdgeInsets(_ edgeInsets: NSDirectionalEdgeInsets, for state: ButtonState) {
        stateConfiguration.edgeInsets[state] = edgeInsets.toButtonEdgeInsets()
        applyConfiguration(to: self, animated: false)
    }
    
    public func setColorAdjustments(_ adjustments: [ColorAdjustment], for state: ButtonState) {
        colorAdjustmentsByState[state] = adjustments
        applyConfiguration(to: self, animated: false)
    }
    
    // MARK: - Internal config logic
    
    private func resolvedValue<T>(for dict: [ButtonState: T]) -> T? {
        let buttonState = state.toButtonState()
        if dict[buttonState] != nil { return dict[buttonState] }
        
        let isFallbackToSelected = (buttonState == .selectHighlighted && dict[.selected] != nil)
        let fallbackValue = isFallbackToSelected ? dict[.selected] : dict[.normal]
        guard let fallbackValue else { return nil }
        
        if T.self is UIColor.Type || T.self is ButtonColor.Type {
            return adjustedColorIfNeeded(fallbackValue, for: buttonState)
        }
        
        return fallbackValue
    }
    
    private func adjustedColorIfNeeded<T>(_ color: T, for state: ButtonState) -> T? {
        guard isColorAdjustmentEnabled else { return color }
        
        // 例如 state 是 highlighted 且 T 為 UIColor 類型，就自動調暗
        if let uiColor = color as? UIColor {
            return adjustedColor(from: uiColor, for: state) as? T
        }
        if let buttonColor = color as? ButtonColor {
            switch buttonColor {
            case .color(let color):
                return ButtonColor.color(adjustedColor(from: color, for: state)) as? T
            case .gradient(let colors, let start, let end, let locations):
                let faded = colors.map { adjustedColor(from: $0, for: state) }
                return ButtonColor.gradient(faded, start: start, end: end, locations: locations) as? T
            case .clear:
                return ButtonColor.color(.clear) as? T
            }
        }
        
        return color
    }
    
    private func adjustedColor(from base: UIColor, for state: ButtonState) -> UIColor {
        guard let adjustments = colorAdjustmentsByState[state] else { return base }
        
        var color = base
        
        for adjustment in adjustments {
            switch adjustment {
            case .alpha(let value):
                color = color.withAlphaComponent(value)
            case .brighten(let amount):
                color = color.adjustBrightness(by: amount)
            case .darken(let amount):
                color = color.adjustBrightness(by: -amount)
            case .desaturate(let amount):
                color = color.adjustSaturation(by: amount)
            }
        }
        
        return color
    }
    
    private func applyConfiguration(to button: UIButton, animated: Bool) {
        guard var config = button.configuration else { return }
        
        config.title = resolvedValue(for: stateConfiguration.title)
        config.baseForegroundColor = resolvedValue(for: stateConfiguration.titleColor)
        config.image = resolvedValue(for: stateConfiguration.image)
        config.imagePadding = resolvedValue(for: stateConfiguration.imagePadding) ?? 0
        config.imagePlacement = resolvedValue(for: stateConfiguration.imagePlacement) ?? .leading
        config.background.strokeColor = resolvedValue(for: stateConfiguration.borderColor)
        config.background.strokeWidth = resolvedValue(for: stateConfiguration.borderWidth) ?? 0
        config.cornerStyle = resolvedValue(for: stateConfiguration.cornerStyle) ?? .dynamic
        config.background.cornerRadius = resolvedValue(for: stateConfiguration.cornerRadius) ?? 0
        
        config.setDefaultContentInsets()
        if let insets = resolvedValue(for: stateConfiguration.edgeInsets) {
            for inset in insets {
                switch inset {
                case .top(let value):
                    config.contentInsets.top = value
                case .leading(let value):
                    config.contentInsets.leading = value
                case .bottom(let value):
                    config.contentInsets.bottom = value
                case .trailing(let value):
                    config.contentInsets.trailing = value
                case .horizontal(let value):
                    config.contentInsets.leading = value
                    config.contentInsets.trailing = value
                case .vertical(let value):
                    config.contentInsets.top = value
                    config.contentInsets.bottom = value
                case .all(let value):
                    config.contentInsets.top = value
                    config.contentInsets.leading = value
                    config.contentInsets.bottom = value
                    config.contentInsets.trailing = value
                }
            }
        }
        
        if let bgColor = resolvedValue(for: stateConfiguration.backgroundColor) {
            switch bgColor {
            case .color(let color):
                resetGradientLayer()
                config.background.backgroundColor = color
            case .gradient(let colors, let start, let end, let locations):
                if colors.count > 1 {
                    gradientLayer
                        .colors(colors.map(\.cgColor))
                        .startPoint(start)
                        .endPoint(end)
                        .locations(locations)
                    adjustGradientLayerIfNeeded(for: config)
                    config.background.backgroundColor = .clear
                } else {
                    resetGradientLayer()
                    config.background.backgroundColor = colors.first ?? .clear
                }
            case .clear:
                resetGradientLayer()
                config.background.backgroundColor = .clear
            }
        } else {
            resetGradientLayer()
            config.background.backgroundColor = .clear
        }
        
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { [weak self] incoming in
            guard let self else { return incoming }
            
            var container = incoming
            
            container.font = resolvedValue(for: stateConfiguration.font)
            container.underlineStyle = resolvedValue(for: stateConfiguration.underlineStyle)
            
            // Fix the title color for the disabled state.
            container.foregroundColor = config.baseForegroundColor
            
            return container
        }
        
        let updates = {
            button.configuration = config
        }
        
        if animated {
            UIView.animate(withDuration: animationDuration,
                           delay: 0,
                           options: [.transitionCrossDissolve, .allowUserInteraction]) {
                button.configuration = config
            }
        } else {
            updates()
        }
    }
    
    private func adjustGradientLayerIfNeeded(for config: UIButton.Configuration?) {
        guard #unavailable(iOS 26), let config else { return }
        
        if config.cornerStyle == .capsule {
            gradientLayer.cornerRadius = bounds.height / 2
        } else {
            gradientLayer.cornerRadius = config.background.cornerRadius
        }
    }
    
    private func resetGradientLayer() {
        gradientLayer.colors = []
        
        if #unavailable(iOS 26) {
            gradientLayer.cornerRadius = 0
        }
    }
}

// MARK: - DSL Builder

public extension AnimatedConfigurableButton {
    @discardableResult func stateConfiguration(_ config: ButtonStateConfiguration) -> Self {
        applyStateConfiguration(config); return self
    }
    
    @discardableResult func title(_ text: String, for state: ButtonState = .normal) -> Self {
        setTitle(text, for: state); return self
    }
    
    @discardableResult func titleColor(_ color: UIColor?, for state: ButtonState = .normal) -> Self {
        setTitleColor(color, for: state); return self
    }
    
    @discardableResult func background(_ color: ButtonColor?, for state: ButtonState = .normal) -> Self {
        setBackgroundColor(color, for: state); return self
    }
    
    @discardableResult func font(_ font: UIFont, for state: ButtonState = .normal) -> Self {
        setFont(font, for: state); return self
    }
    
    @discardableResult func isUnderlineEnabled(_ enabled: Bool, for state: ButtonState = .normal) -> Self {
        setUnderlineEnabled(enabled, for: state); return self
    }
    
    @discardableResult func image(_ image: UIImage?, for state: ButtonState = .normal) -> Self {
        setImage(image, for: state); return self
    }
    
    @discardableResult func imagePadding(_ padding: CGFloat, for state: ButtonState = .normal) -> Self {
        setImagePadding(padding, for: state); return self
    }
    
    @discardableResult func imagePlacement(_ placement: NSDirectionalRectEdge, for state: ButtonState = .normal) -> Self {
        setImagePlacement(placement, for: state); return self
    }
    
    @discardableResult func border(color: UIColor?, width: CGFloat, for state: ButtonState = .normal) -> Self {
        setBorderColor(color, for: state)
        setBorderWidth(width, for: state)
        return self
    }
    
    @discardableResult func cornerStyle(_ style: UIButton.Configuration.CornerStyle, for state: ButtonState = .normal) -> Self {
        setCornerStyle(style, for: state); return self
    }
    
    @objc @discardableResult override func cornerRadius(_ radius: CGFloat) -> Self {
        setCornerRadius(radius, for: .normal); return self
    }
    
    @discardableResult func cornerRadius(_ radius: CGFloat, for state: ButtonState = .normal) -> Self {
        setCornerRadius(radius, for: state); return self
    }
    
    @discardableResult func edgeInsets(_ insets: [EdgeInset], for state: ButtonState = .normal) -> Self {
        setEdgeInsets(insets, for: state); return self
    }
    
    @discardableResult func edgeInsets(_ edgeInsets: NSDirectionalEdgeInsets, for state: ButtonState = .normal) -> Self {
        setEdgeInsets(edgeInsets, for: state); return self
    }
    
    @discardableResult func colorAdjustments(_ adjustments: [ColorAdjustment], for state: ButtonState) -> Self {
        guard state != .normal else { return self }
        setColorAdjustments(adjustments, for: state); return self
    }
    
    @discardableResult func colorAdjustmentEnabled(_ enabled: Bool) -> Self {
        isColorAdjustmentEnabled = enabled; return self
    }
    
    @discardableResult func animated(_ enabled: Bool) -> Self {
        isAnimationEnabled = enabled; return self
    }
    
    @discardableResult func animationDuration(_ duration: TimeInterval) -> Self {
        animationDuration = duration; return self
    }
}

// MARK: - Helper

fileprivate extension UIControl.State {
    func toButtonState() -> AnimatedConfigurableButton.ButtonState {
        if contains(.disabled) {
            .disabled
        } else if contains(.highlighted) && contains(.selected) {
            .selectHighlighted
        } else if contains(.highlighted) {
            .highlighted
        } else if contains(.selected) {
            .selected
        } else {
            .normal
        }
    }
}

fileprivate extension UIColor {
    func adjustBrightness(by amount: CGFloat) -> UIColor {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        guard getHue(&h, saturation: &s, brightness: &b, alpha: &a) else { return self }
        return UIColor(hue: h, saturation: s, brightness: min(max(b + amount, 0), 1), alpha: a)
    }
    
    func adjustSaturation(by amount: CGFloat) -> UIColor {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        guard getHue(&h, saturation: &s, brightness: &b, alpha: &a) else { return self }
        return UIColor(hue: h, saturation: min(max(s + amount, 0), 1), brightness: b, alpha: a)
    }
}
