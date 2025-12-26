import UIKit

@objc
public extension UIButton {
    @discardableResult func isEnabled(_ enabled: Bool) -> Self {
        isEnabled = enabled; return self
    }
    
    @discardableResult func isSelected(_ selected: Bool) -> Self {
        isSelected = selected; return self
    }
    
    @discardableResult func changesSelectionAsPrimaryAction(_ enabled: Bool) -> Self {
        changesSelectionAsPrimaryAction = enabled; return self
    }
    
    @discardableResult func onTap(_ target: Any?, action: Selector) -> Self {
        addTarget(target, action: action, for: .touchUpInside); return self
    }
    
    @discardableResult func onPress(_ target: Any?, action: Selector) -> Self {
        addTarget(target, action: action, for: .touchDown); return self
    }
    
    @discardableResult func onCancel(_ target: Any?, action: Selector) -> Self {
        addTarget(target, action: action, for: [.touchUpOutside, .touchCancel]); return self
    }
}
