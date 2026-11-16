import UIKit

public extension GradientView {
    enum Direction {
        case horizontal, vertical
        case custom(start: CGPoint, end: CGPoint)
        
        var startPoint: CGPoint {
            switch self {
            case .horizontal, .vertical: .zero
            case .custom(let start, _): start
            }
        }
        
        var endPoint: CGPoint {
            switch self {
            case .horizontal: CGPoint(x: 1, y: 0)
            case .vertical: CGPoint(x: 0, y: 1)
            case .custom(_, let end): end
            }
        }
    }
}

open class GradientView: UIView {
    public var colors: [UIColor] {
        didSet {
            updateLayer()
        }
    }
    
    public var direction: Direction {
        didSet {
            updateLayer()
        }
    }
    
    public var locations: [NSNumber] {
        didSet {
            updateLayer()
        }
    }
    
    private var gradientLayer: CAGradientLayer { layer as! CAGradientLayer }
    
    public override class var layerClass: AnyClass { CAGradientLayer.self }
    
    // MARK: Init
    
    public init(colors: [UIColor], direction: Direction = .horizontal, locations: [NSNumber] = [0, 1]) {
        self.colors = colors
        self.direction = direction
        self.locations = locations
        super.init(frame: .zero)
        updateLayer()
    }
    
    public override init(frame: CGRect = .zero) {
        self.colors = []
        self.direction = .horizontal
        self.locations = [0, 1]
        super.init(frame: frame)
        updateLayer()
    }
    
    public required init?(coder: NSCoder) {
        self.colors = []
        self.direction = .horizontal
        self.locations = [0, 1]
        super.init(coder: coder)
        updateLayer()
    }
    
    // MARK: Private
    
    private func updateLayer() {
        gradientLayer.colors = colors.map(\.cgColor)
        gradientLayer.startPoint = direction.startPoint
        gradientLayer.endPoint = direction.endPoint
        gradientLayer.locations = locations
    }
}
