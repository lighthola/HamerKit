import Foundation

public extension Dictionary where Key == String {
    /// 將字典轉換為 JSON 字串
    /// - Parameters:
    ///   - outputFormatting: JSON 輸出格式，預設無格式化。常用選項：
    ///     - `.prettyPrinted`：縮排美化輸出
    ///     - `.sortedKeys`：key 按字母排序
    ///   - expandJSONStringKeys: 需要將 JSON 字串展開為巢狀物件的 key 集合，預設不展開
    /// - Returns: JSON 字串，若轉換失敗則回傳 `nil`
    func toJSONString(
        outputFormatting: JSONSerialization.WritingOptions = [],
        expandJSONStringKeys: Set<String> = []
    ) -> String? {
        let pairs: [(String, Any)] = self.map { key, value in
            if expandJSONStringKeys.contains(key),
               let str = value as? String,
               let data = str.data(using: .utf8),
               let obj = try? JSONSerialization.jsonObject(with: data) {
                return (key, obj)
            }
            return (key, value)
        }
        
        let expanded = Dictionary<String, Any>(uniqueKeysWithValues: pairs)
        
        guard JSONSerialization.isValidJSONObject(expanded) else { return nil }
        guard let data = try? JSONSerialization.data(withJSONObject: expanded, options: outputFormatting) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
