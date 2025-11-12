import Foundation

public extension NumberFormatter {
    
    /// 用於顯示台幣金額的格式化工具
    /// - 貨幣符號: $ (台灣常用的美元符號表示新台幣)
    /// - 小數位數: 0 (台幣通常不顯示小數)
    /// - 範例: 1234.56 → "$1,235"
    /// - 注意: 使用 $ 而非 NT$ 或 TWD,符合台灣本地顯示習慣
    static var twdCurrency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        formatter.currencySymbol = "$"
        return formatter
    }
    
    /// 用於顯示整數的十進位格式化工具
    /// - 樣式: 十進位數字格式(包含千位分隔符)
    /// - 小數位數: 0 (只顯示整數部分,會四捨五入)
    /// - 範例: 1234.56 → "1,235"
    static var integerDecimal: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        return formatter
    }
    
    /// 用於顯示帶有 "k" 後綴的數字格式化工具
    /// - 小數位數: 0-1 位(自動省略不必要的小數，無條件捨去)
    /// - 後綴: "k" (表示千位)
    /// - 範例: 1.56 → "1.5k", 2.01 → "2.0k"
    /// - 注意: 使用前需先將數字除以 1000
    static var kSuffixNumber: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1
        formatter.roundingMode = .floor
        formatter.positiveSuffix = "k"
        return formatter
    }
}
