import UIKit

public extension PopoverMenuViewController {
    class Action {
        let title: String?
        let image: UIImage?
        let handler: () -> Void
        
        public init(title: String? = nil, image: UIImage? = nil, handler: @escaping ()->()) {
            self.title = title
            self.image = image
            self.handler = handler
        }
    }
    
    func popover(on barButtonItem: UIBarButtonItem, from presentingViewController: UIViewController, animated: Bool = true) {
        self.barButtonItem = barButtonItem
        presentingViewController.present(self, animated: animated)
    }
}

public class PopoverMenuViewController: UITableViewController, UIPopoverPresentationControllerDelegate {
    public var sourceView: UIView? {
        get { popoverPresentationController?.sourceView }
        set { popoverPresentationController?.sourceView = newValue}
    }
    
    public var sourceRect: CGRect {
        get { popoverPresentationController?.sourceRect ?? .zero}
        set { popoverPresentationController?.sourceRect = newValue}
    }
    
    public var width: CGFloat = 200 {
        didSet {
            updatePreferredContentSize()
        }
    }
    
    public var itemHeight: CGFloat = 40 {
        didSet {
            updatePreferredContentSize()
        }
    }
    
    public weak var barButtonItem: UIBarButtonItem? {
        didSet {
            if let itemView = barButtonItem?.itemView {
                sourceView = itemView
                let y = 50 + actions.count * 20
                sourceRect = CGRect(x: 0, y: y, width: 0, height: 0)
            }
        }
    }
    
    private var actions: [Action] = []
    
    private let cellIdentifier = "Cell"
    
    // MARK: Init
    
    public init(actions: [Action]) {
        self.actions = actions
        super.init(style: .plain)
        modalPresentationStyle = .popover
        updatePreferredContentSize()
        presentationController?.delegate = self
        popoverPresentationController?.permittedArrowDirections = []
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    // MARK: Lefecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.rowHeight = itemHeight
        tableView.separatorInset = .zero
        tableView.isScrollEnabled = false
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let popoverView = popoverPresentationController?.containerView {
            popoverView.layer.shadowColor = UIColor.black.cgColor
            popoverView.layer.shadowRadius = 8
            popoverView.layer.shadowOffset = .init(width: 0, height: 1)
            popoverView.layer.shadowOpacity = 0.5
        }
    }
    
    // MARK: Table View (Data Source & Delegate)
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        actions.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let action = actions[indexPath.row]
        cell.textLabel?.text = action.title
        cell.imageView?.image = action.image
        cell.selectionStyle = .none
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        guard let action = actions[safe: indexPath.row] else { return }
        
        dismiss(animated: false) {
            action.handler()
        }
    }
    
    // MARK: UIAdaptivePresentationControllerDelegate (Popover)
    
    public func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        .none // To present this view as a popover forcefully.
    }
    
    // MARK: Private
    
    private func updatePreferredContentSize() {
        preferredContentSize = CGSize(width: width,
                                      height: itemHeight * CGFloat(actions.count))
    }
}

// MARK: UIBarButtonItem

private extension UIBarButtonItem {
    var itemView: UIView? {
        value(forKey: "view") as? UIView
    }
}
