import UIKit

extension CGColor {
    static var clear: CGColor {
        UIColor.clear.cgColor
    }
    
    static func white(_ white: CGFloat, alpha: CGFloat = 1) -> CGColor {
        UIColor(white: white, alpha: alpha).cgColor
    }
    
    static func rgb(_ r: Int, _ g: Int, _ b: Int, _ a: CGFloat = 1) -> CGColor {
        UIColor.rgb(r, g, b, a).cgColor
    }
    
    static func hex(_ hex: String) -> CGColor {
        UIColor.hex(hex).cgColor
    }
    
    static func hex(_ hex: String, alpha: CGFloat) -> CGColor {
        UIColor.hex(hex, alpha: alpha).cgColor
    }
}
