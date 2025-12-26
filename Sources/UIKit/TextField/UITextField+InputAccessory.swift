import UIKit

public extension UITextField {
    /// 將鍵盤設為數字鍵盤，並加上完成按鈕
    func enableNumberPadWithDoneButton(title: String) {
        guard let screenWidth = window?.windowScene?.screen.bounds.size.width else { return }
        let size = CGSize(width: screenWidth, height: 30)
        let toolbar = UIToolbar(frame: CGRect(origin: .zero, size: size))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton: UIBarButtonItem = UIBarButtonItem(title: title,
                                                          style: .done,
                                                          target: self,
                                                          action: #selector(doneButtonAction))
        toolbar.setItems([space, doneButton], animated: false)
        toolbar.sizeToFit()
        
        self.keyboardType = .numberPad
        self.inputAccessoryView = toolbar
    }
    
    @objc private func doneButtonAction() {
        self.resignFirstResponder()
    }
}
