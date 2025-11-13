import UIKit

public extension UINavigationBar {
    func hideBackButtonText() {
        topItem?.backButtonDisplayMode = .minimal
    }
    
    func setTitleTextAttributes(_ attributes: [NSAttributedString.Key : Any]) {
        let appearance = standardAppearance.copy()
        appearance.titleTextAttributes = attributes
        updateAppearance(appearance)
    }
    
    func setBackgroundColor(_ color: UIColor) {
        let appearance = standardAppearance.copy()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = color
        updateAppearance(appearance)
    }
    
    func setGradientBackground(colors: [UIColor],
                               startPoint: CGPoint = .zero,
                               endPoint: CGPoint = CGPoint(x: 1, y: 0),
                               locations: [CGFloat] = [0, 1]) {
        let appearance = standardAppearance.copy()
        let size = CGSize(width: 100, height: 44)
        let image = UIImage(size: size, colors: colors, startPoint: startPoint, endPoint: endPoint, locations: locations)
        let resizedImage = image?.resizableImage(withCapInsets: .zero, resizingMode: .stretch)
        appearance.backgroundImage = resizedImage
        updateAppearance(appearance)
    }
    
    func setupShadowColor(_ color: UIColor) {
        let appearance = standardAppearance.copy()
        appearance.shadowColor = color
        updateAppearance(appearance)
    }
    
    // MARK: Private
    
    private func updateAppearance(_ appearance: UINavigationBarAppearance) {
        standardAppearance = appearance
        scrollEdgeAppearance = appearance
    }
}
