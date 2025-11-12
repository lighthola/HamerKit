import Foundation
import SwiftSoup

public extension NSAttributedString {
    /// 將 html 轉換成富文本
    convenience init?(html: String) throws {
        let htmlString = try Entities.unescape(html)
        
        guard let data = htmlString.data(using: .utf8) else { return nil }

        // HTML 轉換選項
        let attributedOptions: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        // 將 HTML 轉換為 NSAttributedString
        try self.init(data: data, options: attributedOptions, documentAttributes: nil)
    }
    
    /// 移除 html 轉換成富文本後產生的空白
    ///
    /// [參考連結](https://stackoverflow.com/questions/75682421/invalid-text-height-with-html-attributed-string)
    func trimmedHTMLAttributedString() -> NSAttributedString {
        let nonNewlines = CharacterSet.whitespacesAndNewlines.inverted
        
        // Find first non-whitespace character and new line character
        let startRange = string.rangeOfCharacter(from: nonNewlines)
        
        // Find last non-whitespace character and new line character.
        let endRange = string.rangeOfCharacter(from: nonNewlines, options: .backwards)
        guard let startLocation = startRange?.lowerBound, let endLocation = endRange?.lowerBound else {
            return self
        }
        // Getting range out of locations. This trim out leading and trailing whitespaces and new line characters.
        let range = NSRange(startLocation...endLocation, in: string)
        return attributedSubstring(from: range)
    }
}
