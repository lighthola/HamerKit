import UIKit

public extension UITableView {
    func reloadData(completion: @escaping ()->()) {
        UIView.animate(withDuration: 0) {
            self.reloadData()
        } completion: { _ in
            completion()
        }
    }
}
