import UIKit

public extension UIViewController {
    func setGradientBackground(colors: [UIColor],
                               direction: GradientView.Direction = .horizontal,
                               locations: [NSNumber] = [0, 1]) {
        if let gradientView = view.subviews.first(where: { $0 is GradientView }) as? GradientView {
            gradientView.colors = colors
            gradientView.direction = direction
            gradientView.locations = locations
        } else {
            let gradientView = GradientView(colors: colors, direction: direction, loactions: locations)
            view.insertSubview(gradientView, at: 0)
            gradientView.mLayChain(pin: .zero)
        }
    }
}
