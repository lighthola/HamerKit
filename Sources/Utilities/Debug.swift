public func memoryAddress(_ object: AnyObject) -> UnsafeMutableRawPointer {
    Unmanaged.passUnretained(object).toOpaque()
}
