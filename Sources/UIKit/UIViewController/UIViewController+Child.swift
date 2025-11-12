import UIKit

public extension UIViewController {
    func add(child: UIViewController, to view: UIView? = nil) {
        let view: UIView = view ?? self.view
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}

// MARK: Stack View

public extension UIViewController {
    func add(child: UIViewController, toStackView stackView: UIStackView) {
        addChild(child)
        stackView.addArrangedSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove(from stackView: UIStackView) {
        willMove(toParent: nil)
        stackView.removeArrangedSubview(self.view)
        removeFromParent()
    }
}
