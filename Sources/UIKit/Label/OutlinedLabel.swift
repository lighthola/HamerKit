import UIKit

public class OutlinedLabel: UILabel {
    public var outlineWidth: CGFloat = 1
    
    public var outlineColor: UIColor = .white
    
    public override func drawText(in rect: CGRect) {
        // Cache the custom settings.
        let shadowOffset = self.shadowOffset
        let textColor = self.textColor
        
        // Draw the outline for the text.
        let c = UIGraphicsGetCurrentContext()
        c?.setLineWidth(outlineWidth)
        c?.setLineJoin(.round)
        c?.setTextDrawingMode(.stroke)
        self.textAlignment = .center
        self.textColor = outlineColor
        super.drawText(in:rect)
        
        // Draw the text.
        c?.setTextDrawingMode(.fill)
        self.textColor = textColor
        self.shadowOffset = CGSize(width: 0, height: 0)
        super.drawText(in:rect)
        
        // Recover the settings.
        self.shadowOffset = shadowOffset
    }
}
