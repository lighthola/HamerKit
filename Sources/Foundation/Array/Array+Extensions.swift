import Foundation

extension Array {
    public subscript(safe index: Int) -> Element? {
        get {
            indices ~= index ? self[index] : nil
        }
        set {
            guard indices ~= index,
                let newValue
            else {
                return
            }
            self[index] = newValue
        }
    }
}
