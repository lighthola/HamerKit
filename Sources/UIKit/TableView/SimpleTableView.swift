import UIKit

public class SimpleTableView<T, Content: UpdatableView>: UIView, UITableViewDataSource, UITableViewDelegate where T == Content.T {
    typealias Cell = SimpleTableViewCell<T, Content>
    
    public let tableView: UITableView = .init()
    
    private var paddingContraints: [NSLayoutConstraint] = []

    public var paddings: UIEdgeInsets = .zero {
        didSet {
            paddingContraints[0].constant = paddings.top
            paddingContraints[1].constant = paddings.left
            paddingContraints[2].constant = -paddings.bottom
            paddingContraints[3].constant = -paddings.right
        }
    }
 
    public var contentInset: UIEdgeInsets {
        get { tableView.contentInset }
        set { tableView.contentInset = newValue }
    }
    
    public var items: [T] = [] {
        didSet { tableView.reloadData() }
    }
    
    // MARK: Init
    
    public override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
    }
    
    // MARK: UITableView Delegate
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        cell.content.updateView(with: items[indexPath.row])
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }

    // MARK: Private
    
    func setupView() {
        tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.separatorColor = .clear
        tableView.layoutMargins = .zero
        tableView.separatorInset = .zero
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        addSubview(tableView)
        paddingContraints = tableView.mLay(pin: .all())
    }
}

public class SimpleTableViewCell<T, Content: UpdatableView>: UITableViewCell where T == Content.T {
    public let content: Content = Content()
    
    // MARK: Init
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    // MARK: Private
    
    private func setupView() {
        preservesSuperviewLayoutMargins = false
        layoutMargins = .zero
        separatorInset = .zero
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(content)
        content
            .mLayChain(pin: .leading(content.layoutMargins.left))
            .mLayChain(pin: .top(content.layoutMargins.top))
            .mLayChain(pin: .trailing(content.layoutMargins.right))
            .mLayChain(pin: .bottom(content.layoutMargins.bottom))
    }
}
