import UIKit

public extension UIImage {
    /// create a color image
    convenience init?(size: CGSize, color: UIColor, scale: CGFloat = 1) {
        let format = UIGraphicsImageRendererFormat()
        format.scale = scale
        format.opaque = false
        
        let image = UIGraphicsImageRenderer(size: size, format: format).image { context in
            color.setFill()
            context.fill(CGRect(origin: .zero, size: size))
        }
        
        guard let cgImage = image.cgImage else { return nil }
        
        self.init(cgImage: cgImage, scale: scale, orientation: .up)
    }
    
    /// create a liner gradient color image
    convenience init?(size: CGSize,
                      colors: [UIColor],
                      startPoint: CGPoint = .zero,
                      endPoint: CGPoint = CGPoint(x: 0, y: 1),
                      locations: [CGFloat] = [0, 1],
                      scale: CGFloat = 1) {
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colors = colors.compactMap(\.cgColor) as CFArray
        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: locations) else {
            return nil
        }
        
        let format = UIGraphicsImageRendererFormat()
        format.opaque = false
        format.scale = scale
        
        let renderer = UIGraphicsImageRenderer(size: size, format: format)
        let resultImage = renderer.image { context in
            let transform = CGAffineTransform(scaleX: size.width, y: size.height)
            let start = startPoint.applying(transform)
            let end = endPoint.applying(transform)
            
            context.cgContext.drawLinearGradient(gradient, start: start, end: end, options: CGGradientDrawingOptions())
        }
        
        guard let cgImage = resultImage.cgImage else {
            return nil
        }
        
        self.init(cgImage: cgImage)
    }
}
