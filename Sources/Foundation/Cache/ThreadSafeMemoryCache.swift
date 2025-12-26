import Foundation

public class ThreadSafeMemoryCache: @unchecked Sendable {
    private var _cache: [String: Any] = [:]
    
    private let lock = NSLock()
    
    public init() {}
    
    // Thread-safe access to the cache
    public var cache: [String: Any]  {
        lock.withLock {
            _cache
        }
    }
    
    // Fetches an item from the cache in a thread-safe way
    public func getValue(forKey key: String) -> Any? {
        lock.withLock {
            return _cache[key]
        }
    }
    
    // Generic get function with type safety
    public func getValue<T>(forKey key: String, as type: T.Type = T.self) -> T? {
        lock.withLock {
            return _cache[key] as? T
        }
    }
    
    // Sets an item in the cache in a thread-safe way
    public func setValue(_ value: Any, forKey key: String) {
        lock.withLock {
            _cache[key] = value
        }
    }
    
    // Removes a specific item from the cache
    public func removeValue(forKey key: String) {
        lock.withLock {
            _cache[key] = nil
        }
    }
    
    // Clears the cache entirely in a thread-safe way
    public func clearCache() {
        lock.withLock {
            _cache.removeAll()
        }
    }
}
