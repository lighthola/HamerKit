import UIKit

public extension UIScreen {
    /// 螢幕縮放比例
    var displayZoomRatio: CGFloat {
        nativeScale / scale
    }
}
