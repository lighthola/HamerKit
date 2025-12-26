import Foundation

extension MyLogger {
    static let fileKey: String = "LoggerFileKey"
    
    public static func file(_ object: Any, file: String = #file, line: Int = #line, function:String = #function) {
        var message = "\(object)"
        
        if let dict = object as? Dictionary<String, AnyObject>,
           let jsonData = try? JSONSerialization.data(withJSONObject: dict,
                                                      options: .prettyPrinted),
           let jsonString = String(bytes: jsonData, encoding: .utf8) {
            message = jsonString
        }
        
        var newLog = "\n💾 - \(file), \(function), line: \(line)\n\(message)\n"
        
        if let logHistory = UserDefaults.standard.string(forKey: fileKey) {
            newLog += logHistory
        }
        
        UserDefaults.standard.set(newLog, forKey: fileKey)
        UserDefaults.standard.synchronize()
    }
    
    public static func getFileLogs() -> String? {
        UserDefaults.standard.string(forKey: fileKey)
    }
    
    public static func cleanFileLogs() {
        UserDefaults.standard.removeObject(forKey: fileKey)
        UserDefaults.standard.synchronize()
    }
}
