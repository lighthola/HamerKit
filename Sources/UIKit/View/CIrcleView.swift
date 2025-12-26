import UIKit

public extension CircleView {
    enum Style {
        case solid(color: UIColor, lineWidth: CGFloat)
        case dashed(color: UIColor, lineWidth: CGFloat, lineCap: CAShapeLayerLineCap, count: Int)
        case filled(color: UIColor)
    }
}

public class CircleView: UIView {
    public var style: Style {
        didSet { updateLayer() }
    }
    
    private let shapeLayer: CAShapeLayer = .init()
        
    // MARK: Init
    
    public init(style: Style = .filled(color: .clear)) {
        self.style = style
        super.init(frame: .zero)
        layer.addSublayer(shapeLayer)
        updateLayer()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        updateLayer()
    }
    
    // MARK: Private
    
    private func updateLayer() {
        CATransaction.begin()
        CATransaction.setDisableActions(true) // disable animation
        
        switch style {
        case .solid(color: let color, lineWidth: let lineWidth):
            drawSolidCircle(color: color, lineWidth: lineWidth)
        case .dashed(color: let color, lineWidth: let lineWidth, let lineCap, count: let count):
            drawDashedCircle(color: color, lineWidth: lineWidth, lineCap: lineCap, count: count)
        case .filled(color: let color):
            drawFilledCircle(color: color)
        }
        
        CATransaction.commit()
    }
    
    private func drawSolidCircle(color: UIColor, lineWidth: CGFloat) {
        shapeLayer.path = makePath()
        shapeLayer.fillColor = backgroundColor?.cgColor ?? .clear
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = lineWidth
    }
    
    private func drawDashedCircle(color: UIColor, lineWidth: CGFloat, lineCap: CAShapeLayerLineCap, count: Int) {
        shapeLayer.path = makeDashedPath(count: count)
        shapeLayer.fillColor = backgroundColor?.cgColor ?? .clear
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineCap = lineCap
    }
    
    private func drawFilledCircle(color: UIColor) {
        shapeLayer.path = makePath()
        shapeLayer.fillColor = color.cgColor
        shapeLayer.strokeColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 0
    }
    
    private func makePath() -> CGPath {
        let length = min(bounds.width, bounds.height)
        let offset = abs(bounds.width - bounds.height) / 2
        let x = bounds.width == length ? 0 : offset
        let y = bounds.height == length ? 0 : offset
        let newBounds = CGRect(origin: .init(x: x, y: y),
                               size: .init(width: length, height: length))
        return UIBezierPath(ovalIn: newBounds).cgPath
    }
    
    private func makeDashedPath(count: Int) -> CGPath {
        let rect = bounds.insetBy(dx: shapeLayer.lineWidth / 2, dy: shapeLayer.lineWidth / 2)
        let radius = min(rect.width, rect.height) / 2
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let path = UIBezierPath()
        let count = count
        let relativeDashLength: CGFloat = 0.25 // a value between 0 and 1
        let increment: CGFloat = .pi * 2 / CGFloat(count)
        
        for i in 0 ..< count {
            let startAngle = increment * CGFloat(i)
            let endAngle = startAngle + relativeDashLength * increment
            path.move(to: CGPoint(x: center.x + radius * cos(startAngle),
                                  y: center.y + radius * sin(startAngle)))
            path.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        }
        
        return path.cgPath
    }
}
