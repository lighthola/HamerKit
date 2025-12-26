// https://stackoverflow.com/questions/952412/uiscrollview-scroll-to-bottom-programmatically#73947743

import UIKit

public extension UIScrollView {
    var isOnTop: Bool { contentOffset.y <= -adjustedContentInset.top }
    
    var isOnBottom: Bool { contentOffset.y >= bottomContentOffsetY }
    
    var isOnLeading: Bool { contentOffset.x <= -adjustedContentInset.left }
    
    var isOnTrailing: Bool { contentOffset.x >= trailingContentOffsetX }
    
    var bottomContentOffsetY: CGFloat {
        max(contentSize.height - bounds.height + adjustedContentInset.bottom,
            -adjustedContentInset.top)
    }
    
    var trailingContentOffsetX: CGFloat {
        max(contentSize.width - bounds.width + adjustedContentInset.right,
            -adjustedContentInset.left)
    }
    
    func scrollToTop(animated: Bool = false, constant: CGFloat = 0) {
        setContentOffset(CGPoint(x: contentOffset.x,
                                 y: -adjustedContentInset.top + constant),
                         animated: animated)
    }
    
    func scrollToBottom(animated: Bool = false, constant: CGFloat = 0) {
        setContentOffset(CGPoint(x: contentOffset.x,
                                 y: bottomContentOffsetY - constant),
                         animated: animated)
    }
    
    func scrollToLeading(animated: Bool = false, constant: CGFloat = 0) {
        setContentOffset(CGPoint(x: -adjustedContentInset.left + constant,
                                 y: contentOffset.y),
                         animated: animated)
    }
    
    func scrollToTrailing(animated: Bool = false, constant: CGFloat = 0) {
        setContentOffset(CGPoint(x: trailingContentOffsetX - constant,
                                 y: contentOffset.y),
                         animated: animated)
    }
    
    func scrollSubviewToVisible(_ view: UIView, animated: Bool = false) {
        let rect = convert(view.bounds, from: view)
        scrollRectToVisible(rect, animated: animated)
    }
}
