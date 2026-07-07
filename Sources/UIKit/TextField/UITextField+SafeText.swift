import UIKit

public extension UITextField {

    /// 以程式方式設定文字，並清除鍵入 undo 堆疊。
    ///
    /// 直接指派 `text` 會繞過系統的 undo manager，若在使用者編輯途中改寫（例如即時格式化、
    /// 數字正規化），undo manager 記錄的位置區間會與實際文字長度失步。使用者接著觸發
    /// 「搖動以復原」時，系統會拿舊的位置區間去替換較短的文字，造成 NSRangeException 崩潰。
    ///
    /// 只要是「程式化」改寫 `text`，就改用此方法，指派後清空 undo 堆疊避免失步。
    func setTextClearingUndo(_ text: String?) {
        self.text = text
        undoManager?.removeAllActions()
    }
}
