import Foundation

public func memoryAddress(_ object: AnyObject) -> UnsafeMutableRawPointer {
    Unmanaged.passUnretained(object).toOpaque()
}

public func randomImageURL(width: Int = 50, height: Int = 50) -> URL {
    return URL(string: "https://picsum.photos/\(width)/\(height)")!
}
