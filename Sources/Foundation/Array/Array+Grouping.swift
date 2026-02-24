import Algorithms
import OrderedCollections

public extension Array {
    
    /// 將元素按指定的 key 分組,確保指定的 keys 存在
    /// - Parameters:
    ///   - keyPath: 用於分組的 keyPath
    ///   - defaultKeys: 必須包含的 keys,即使沒有對應的元素也會建立空陣列
    /// - Returns: 以 key 為 key 的字典
    func grouped<Key: Hashable>(
        by keyPath: KeyPath<Element, Key>,
        ensuring defaultKeys: [Key] = []
    ) -> [Key: [Element]] {
        let grouped = Dictionary(grouping: self, by: { $0[keyPath: keyPath] })
        
        let allKeys = chain(defaultKeys, grouped.keys).uniqued()
        
        return Dictionary(uniqueKeysWithValues: allKeys.map {
            ($0, grouped[$0] ?? [])
        })
    }
    
    /// 將元素按指定的 key 分組並排序,確保指定的 keys 存在
    /// - Parameters:
    ///   - keyPath: 用於分組的 keyPath
    ///   - defaultKeys: 必須包含的 keys
    ///   - sortBy: 自訂排序方式
    /// - Returns: 排序後的有序字典
    func groupedAndSorted<Key: Hashable>(
        by keyPath: KeyPath<Element, Key>,
        ensuring defaultKeys: [Key] = [],
        sortBy: @escaping (Key, Key) -> Bool
    ) -> OrderedDictionary<Key, [Element]> {
        let grouped = self.grouped(by: keyPath, ensuring: defaultKeys)
        
        return OrderedDictionary(
            uniqueKeysWithValues: grouped.sorted { sortBy($0.key, $1.key) }
        )
    }
    
    /// 將元素按指定的 key 分組並排序(使用 Comparable),確保指定的 keys 存在
    /// - Parameters:
    ///   - keyPath: 用於分組的 keyPath
    ///   - defaultKeys: 必須包含的 keys
    /// - Returns: 按 key 排序的有序字典
    func groupedAndSorted<Key: Hashable & Comparable>(
        by keyPath: KeyPath<Element, Key>,
        ensuring defaultKeys: [Key] = []
    ) -> OrderedDictionary<Key, [Element]> {
        groupedAndSorted(by: keyPath, ensuring: defaultKeys, sortBy: <)
    }
}
