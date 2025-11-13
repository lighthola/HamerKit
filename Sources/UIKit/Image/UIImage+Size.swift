import UIKit

public extension UIImage {
    func resize(to size: CGSize, scale: CGFloat? = nil) -> UIImage? {
        let format = UIGraphicsImageRendererFormat()
        format.opaque = false
        format.scale = scale ?? self.scale
        
        let renderer = UIGraphicsImageRenderer(size: size, format: format)
        
        return renderer.image { context in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
