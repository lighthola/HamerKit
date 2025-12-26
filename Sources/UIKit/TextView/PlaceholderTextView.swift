import UIKit

public class PlaceholderTextView: UITextView, @MainActor NSTextStorageDelegate {
    public var placeholder: String? {
        get { placeholderLabel.text }
        set { placeholderLabel.text = newValue }
    }
    
    public lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        addSubview(label)
        
        label.mLayChain(pin: .init(top: textContainerInset.top,
                                   left: textContainer.lineFragmentPadding,
                                   bottom: textContainerInset.bottom,
                                   right: textContainer.lineFragmentPadding))
        
        label.font = font
        label.textColor = .init(red: 199 / 255, green: 199 / 255, blue: 205 / 255, alpha: 1)
        label.numberOfLines = 0
        
        return label
    }()
    
    // MARK: Init
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        textStorage.delegate = self
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    // MARK: NSTextStorageDelegate
    
    public func textStorage(_ textStorage: NSTextStorage, didProcessEditing editedMask: NSTextStorage.EditActions, range editedRange: NSRange, changeInLength delta: Int) {
        if editedMask.contains(.editedCharacters) {
            placeholderLabel.isHidden = !text.isEmpty
        }
    }
}
