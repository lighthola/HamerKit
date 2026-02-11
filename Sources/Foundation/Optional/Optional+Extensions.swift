public extension Optional {
    func orDefault(_ defaultValue: Wrapped) -> Wrapped {
        switch self {
        case .none:
            defaultValue
        case .some(let wrapped):
            wrapped
        }
    }
}
