import UIKit

public class SimpleStackView<T, Cell: UpdatableView>: UIView where T == Cell.T {
    public var items: [T] = [] {
        didSet { reloadData() }
    }
    
    public let stackView: UIStackView = .init()
    
    public var innerSpacing: CGFloat {
        get { stackView.spacing }
        set { stackView.spacing = newValue }
    }
    
    public override var layoutMargins: UIEdgeInsets {
        get { stackView.layoutMargins }
        set { stackView.layoutMargins = newValue }
    }
    
    // MARK: Init
    
    public override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    // MARK: Public
    
    public func reloadData() {
        cleanSubviews()
        addSubviews()
    }
}

private extension SimpleStackView {
    func setupView() {
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 0
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .zero
        addSubview(stackView)
        stackView.mLayChain(pin: .all())
    }
    
    func cleanSubviews() {
        for subview in stackView.arrangedSubviews {
            stackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
    }
    
    func addSubviews() {
        for item in items {
            let cell = Cell()
            cell.updateView(with: item)
            stackView.addArrangedSubview(cell)
        }
    }
}
