import UIKit

public protocol KeyboardHandling {
    func setupKeyboardNotifications()
    func keyboardWillShow(_ notification: Notification)
    func keyboardWillHide(_ notification: Notification)
    func dismissKeyboardWhenClickView()
}

@MainActor
public extension KeyboardHandling where Self: UIViewController {
    /// The scroll view in ViewController must be defined with the @objc attribute to be accessible via KVC..
    private var _scrollView: UIScrollView? {
        get {
            value(forKey: "scrollView") as? UIScrollView
        }
    }
    
    func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification, object: nil, queue: .main) { [weak self] notification in
            self?.keyboardWillShow(notification)
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { [weak self] notification in
            self?.keyboardWillHide(notification)
        }
    }
    
    func keyboardWillShow(_ notification: Notification) {
        defaultKeyboardWillShow(notification)
    }
    
    func keyboardWillHide(_ notification: Notification) {
        defaultKeyboardWillHide(notification)
    }
    
    func dismissKeyboardWhenClickView() {
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer { [weak self] in
            self?.dismissKeyboard($0)
        }
        view.addGestureRecognizer(tap)
    }
    
    // MARK: Private
    
    private func dismissKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
}

// MARK: Default

@MainActor
public extension KeyboardHandling where Self: UIViewController {
    /// Adjust Scroll View Insets
    func defaultKeyboardWillShow(_ notification: Notification) {
        guard let _scrollView else { return }
        
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        // keyboard size
        let kbSize = keyboardFrame.cgRectValue.size
        
        // adjust scrollview content insets
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height + 16, right: 0)
        _scrollView.contentInset = contentInsets
        _scrollView.scrollIndicatorInsets = contentInsets
        
        //
        // If active text field is hidden by keyboard, scroll it so it's visible
        // Your app might not need or want this behavior.
        //
        // var aRect = self.view.frame;
        // aRect.size.height -= kbSize.height;
        // if let tf = self.activeTF, !CGRectContainsPoint(aRect, tf.frame.origin)  {
        //     _scrollView.scrollRectToVisible(tf.frame, animated: true)
        // }
    }
    
    func defaultKeyboardWillHide(_ notification: Notification) {
        guard let _scrollView else { return }
        _scrollView.contentInset = .zero
        _scrollView.scrollIndicatorInsets = .zero
    }
}
