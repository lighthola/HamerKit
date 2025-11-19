import UIKit

public protocol StoryboardInstantiable: UIViewController {
    static func instantiate(from name: String) -> Self
}

public extension StoryboardInstantiable {
    static func instantiate(from name: String = "Main") -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: name, bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: id)
        
        guard let typedVC = vc as? Self else {
            assertionFailure("⚠️ Storyboard ID '\(id)' does NOT match \(Self.self).")
            return Self.init() // fallback，避免 production crash
        }
        
        return typedVC
    }
}
