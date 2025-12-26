import Foundation

public extension NSAttributedString {
    /// Convenience initializer for creating an NSAttributedString with bullet points.
    convenience init(
        stringWithBulletPoints string: String,
        bulletPointsSymbol bulletPoints: String,
        attributes: [NSAttributedString.Key: Any]?
    ) {
        self.init(stringWithBulletPoints: string, bulletPointsSymbol: bulletPoints, attributes: attributes, skipFirstLine: false, firstLineAttributes: nil)
    }
    
    /// Convenience initializer for creating an NSAttributedString with bullet points.
    convenience init(
        stringWithBulletPoints string: String,
        bulletPointsSymbol bulletPoints: String,
        attributes: [NSAttributedString.Key: Any]?,
        skipFirstLine: Bool,
        firstLineAttributes: [NSAttributedString.Key: Any]?
    ) {
        self.init(
            stringWithListItems: string,
            listsItem: .text(bulletPoints),
            attributes: attributes,
            skipFirstLine: skipFirstLine,
            firstLineAttributes: firstLineAttributes
        )
    }
    
    /// Convenience initializer for creating an NSAttributedString with numbered lists.
    convenience init(
        stringWithNumberLists string: String,
        startingNumberForNumberedLists startNumberedLists: Int,
        attributes: [NSAttributedString.Key: Any]?
    ) {
        self.init(stringWithNumberLists: string, startingNumberForNumberedLists: startNumberedLists, attributes: attributes, skipFirstLine: false, firstLineAttributes: nil)
    }
    
    /// Convenience initializer for creating an NSAttributedString with numbered lists.
    convenience init(
        stringWithNumberLists string: String,
        startingNumberForNumberedLists startNumberedLists: Int,
        attributes: [NSAttributedString.Key: Any]?,
        skipFirstLine: Bool,
        firstLineAttributes: [NSAttributedString.Key: Any]?
    ) {
        self.init(
            stringWithListItems: string,
            listsItem: .number(startNumberedLists),
            attributes: attributes,
            skipFirstLine: skipFirstLine,
            firstLineAttributes: firstLineAttributes
        )
    }
}

public extension NSAttributedString {
    /// Enumeration to represent different types of list items.
    enum ListsItem {
        case text(String)
        case number(Int)
    }
    
    /// Convenience initializer for creating an NSAttributedString with list items.
    ///
    /// - Parameters:
    ///   - stringWithListItems: Input string.
    ///   - listsItem: Type of list item (text or number).
    ///   - attributes: Attributes for the list items.
    ///   - skipFirstLine: Flag to skip the first line in the input string.
    ///   - firstLineAttributes: Attributes for the first line if not skipped.
    convenience init(
        stringWithListItems string: String,
        listsItem: ListsItem,
        attributes: [NSAttributedString.Key: Any]?,
        skipFirstLine: Bool,
        firstLineAttributes: [NSAttributedString.Key: Any]?
    ) {
        // Split the input string into lines
        var lines = string.componentsSeparateByNewLine()
        let firstLine = skipFirstLine ? lines.removeFirst() : nil
        let firstLineAttributedString: NSAttributedString? = firstLine != nil ? NSAttributedString(string: firstLine!, attributes: firstLineAttributes) : nil
        
        // If the input string contains only one line and no lists item, create and return the attributed string
        if lines.isEmpty, let firstLineAttributedString {
            self.init(attributedString: firstLineAttributedString)
            return
        }
        
        // Generate the list string based on the specified list item type
        let listsString = switch listsItem {
        case .text(let bulletPoints):
            lines.toBulletedListsString(with: bulletPoints)
        case .number(let number):
            lines.toNumberedListsString(startingFrom: number)
        }
        
        // Create the final attributed string based on the specified conditions
        if skipFirstLine, let firstLineAttributedString {
            let attributedString = NSMutableAttributedString()
            let listsAttributedString = NSAttributedString(string: listsString, attributes: attributes)
            
            // Append the first line, a newline character, and the list items
            attributedString.append(firstLineAttributedString)
            attributedString.append(.init(string: "\n"))
            attributedString.append(listsAttributedString)
            
            self.init(attributedString: attributedString)
        } else {
            // Create an attributed string without considering the first line
            self.init(string: listsString, attributes: attributes)
        }
    }
}

// MARK: - Helper

private extension String {
    func componentsSeparateByNewLine() -> [String] {
        let string = trimmingCharacters(in: .whitespacesAndNewlines)
        return string.components(separatedBy: .newlines)
    }
}

private extension Array where Element == String {
    func toBulletedListsString(with bulletPoint: String) -> String {
        enumerated().reduce("") { partialResult, line in
            let i = line.offset
            var newLine = bulletPoint + line.element
            if i < count-1 { newLine += "\n" }
            return partialResult + newLine
        }
    }
    
    func toNumberedListsString(startingFrom number: Int) -> String {
        enumerated().reduce("") { partialResult, line in
            let i = line.offset
            var newLine = "\(number+i).\t" + line.element
            if i < count-1 { newLine += "\n" }
            return partialResult + newLine
        }
    }
}

