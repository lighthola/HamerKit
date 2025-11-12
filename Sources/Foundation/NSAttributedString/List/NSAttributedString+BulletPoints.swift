import UIKit

public extension NSAttributedString {
    convenience init(
        string: String,
        bulletPointsSymbol bulletPoints: String = "•\t",
        font: UIFont,
        textColor: UIColor,
        indentation: CGFloat = 17,
        lineSpacing: CGFloat = 2,
        paragraphSpacing: CGFloat = 2,
        skipFirstLine: Bool = false
    ) {
        let paragraphStyle = {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.tabStops = [ NSTextTab(textAlignment: .left, location: indentation, options: [:]) ]
            paragraphStyle.defaultTabInterval = indentation
            paragraphStyle.headIndent = indentation
            paragraphStyle.lineSpacing = lineSpacing
            paragraphStyle.paragraphSpacing = paragraphSpacing
            return paragraphStyle
        }()
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: textColor,
            .paragraphStyle: paragraphStyle
        ]
        
        if skipFirstLine {
            let firstLineParagraphStyle = {
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = lineSpacing
                paragraphStyle.paragraphSpacing = paragraphSpacing
                return paragraphStyle
            }()
            let firstLineAttributes: [NSAttributedString.Key: Any] = [
                .font: font,
                .foregroundColor: textColor,
                .paragraphStyle: firstLineParagraphStyle
            ]
            self.init(stringWithBulletPoints: string, bulletPointsSymbol: bulletPoints, attributes: attributes, skipFirstLine: true, firstLineAttributes: firstLineAttributes)
        } else {
            self.init(stringWithBulletPoints: string, bulletPointsSymbol: bulletPoints, attributes: attributes)
        }
    }
}
