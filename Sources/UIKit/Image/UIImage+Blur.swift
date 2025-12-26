import UIKit

public extension UIImage {
    func addBlur(_ radius: CGFloat = 10) -> UIImage? {
        guard let ciImage = CIImage(image: self),
              let filter = CIFilter(name: "CIGaussianBlur") else { return nil }
        
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        filter.setValue(radius, forKey: kCIInputRadiusKey) // 模糊程度
        
        guard let outputImage = filter.outputImage else { return nil }
        
        let context = CIContext(options: nil)
        
        // 模糊後整體會縮小，周圍會產生無用的區域，需要移除。
        let croppedImage = outputImage.cropped(to: ciImage.extent)
        
        guard let cgImage = context.createCGImage(croppedImage, from: croppedImage.extent) else { return nil }
        let blurredImage = UIImage(cgImage: cgImage, scale: self.scale, orientation: .up)
        
        return blurredImage
    }
}
