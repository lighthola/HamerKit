import Foundation

public extension Data {
    /// 將 Data 編碼為 Base64URL 字串
    /// 將標準 Base64 的 `+` 替換為 `-`，`/` 替換為 `_`，並移除 `=` padding
    func base64URLEncodedString() -> String {
        return base64EncodedString()
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "=", with: "")
    }
}

public extension String {
    /// 將字串以 UTF-8 編碼後轉為 Base64URL 字串
    /// - Returns: Base64URL 編碼後的字串，若 UTF-8 轉換失敗則回傳 `nil`
    func base64URLEncoded() -> String? {
        return data(using: .utf8)?.base64URLEncodedString()
    }
    
    /// 將 Base64URL 字串解碼為 Data
    /// 會自動將 `-` 還原為 `+`，`_` 還原為 `/`，並補回 `=` padding
    /// - Returns: 解碼後的 Data，若格式不合法則回傳 `nil`
    func base64URLDecoded() -> Data? {
        var base64 = self
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        
        // Re-add padding if needed
        let remainder = base64.count % 4
        if remainder > 0 {
            base64 += String(repeating: "=", count: 4 - remainder)
        }
        
        return Data(base64Encoded: base64)
    }
}
