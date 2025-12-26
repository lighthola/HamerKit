import Foundation

public let logger = MyLogger.self

public enum MyLogger {
    public static func log(_ object: Any, file: String = #file, line: Int = #line, function:String = #function, symbol: String = "") {
        var message = "\(object)"
        
        if let dict = object as? Dictionary<String, AnyObject>,
           let jsonData = try? JSONSerialization.data(withJSONObject: dict,
                                                      options: .prettyPrinted),
           let jsonString = String(bytes: jsonData,
                                   encoding: .utf8) {
           message = jsonString
        }
        
        print("\n\(symbol) - \(file), \(function), line: \(line)\n\(message)\n")
    }

    public static func debug(_ object: Any, file: String = #file, line: Int = #line, function:String = #function) {
        log(object, file: file, line: line, function: function, symbol: "✅")
    }

    public static func error(_ object: Any, file: String = #file, line: Int = #line, function:String = #function) {
        log(object, file: file, line: line, function: function, symbol: "❌")
    }
}
