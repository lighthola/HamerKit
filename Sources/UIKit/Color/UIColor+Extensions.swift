import UIKit

public extension UIColor {
    static func random() -> UIColor {
        return UIColor(
            red: CGFloat.random(in: 0...1),
            green: CGFloat.random(in: 0...1),
            blue: CGFloat.random(in: 0...1),
            alpha: 1.0
        )
    }
}

public extension UIColor {
    static func rgb(_  r: Int, _ g: Int, _ b: Int, _ a: CGFloat = 1) -> UIColor {
        let red = CGFloat(r).clampedNormalized(to: 0...255)
        let green = CGFloat(g).clampedNormalized(to: 0...255)
        let blue = CGFloat(b).clampedNormalized(to: 0...255)
        let alpha = a.clamped(to: 0...1)
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}

public extension UIColor {
    /// Creates a color from a 6-digit or 8-digit hex string (the latter includes alpha).
    /// Supports hex string with or without "#".
    static func hex(_ hex: String) -> UIColor {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        // RGB: 6 or RGBA: 8
        guard hexSanitized.count == 6 || hexSanitized.count == 8 else { return UIColor() }
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let r, g, b, a: CGFloat
        
        if hexSanitized.count == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
            a = 1.0
        } else {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
        }
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
    /// Creates a color from a 6-digit hex string (with or without a leading "#"),
    /// and a supplied alpha value.
    static func hex(_ hex: String, alpha: CGFloat) -> UIColor {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        // RGB: 6
        guard hexSanitized.count == 6 else { return UIColor() }
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0x0000FF) / 255.0
        let a = max(0, min(alpha, 1))
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
    /// Converts the color to a hex string, optionally including the alpha component.
    func hex(includeAlpha: Bool = false) -> String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        // 提取 RGBA 分量
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        // 转换为 0-255 范围的整数
        let r = Int(red * 255)
        let g = Int(green * 255)
        let b = Int(blue * 255)
        let a = Int(alpha * 255)
        
        // 根据需求输出是否包含 alpha
        if includeAlpha {
            return String(format: "#%02X%02X%02X%02X", r, g, b, a)
        } else {
            return String(format: "#%02X%02X%02X", r, g, b)
        }
    }
}
