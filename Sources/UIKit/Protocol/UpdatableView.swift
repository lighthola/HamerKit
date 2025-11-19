import UIKit

public protocol UpdatableView: UIView {
    associatedtype T
    func updateView(with data: T)
}
