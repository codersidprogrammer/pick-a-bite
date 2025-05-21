//
//  Logger.swift
//  kemekuy
//
//  Created by Dimaseditiya on 15/03/25.
//

import Foundation

enum LogLevel: String {
    case info = "[INFO] "
    case warning = "[WARN] "
    case error = "[ERROR]"
    case debug = "[DEBUG]"
}

struct Logger {
    static func log(
        _ message: String,
        level: LogLevel = .info,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
        let timestamp = formattedTimeStamp()
        let filename = (file as NSString).lastPathComponent
        print("\(timestamp) \(level.rawValue)[\(filename):\(line)] \(function) → \(message)")
    }
    
    static func log(dictionary: [String: Any],
                    level: LogLevel = .info,
                    file: String = #file,
                    function: String = #function,
                    line: Int = #line) {
        
        var result = ""
        for (key, value) in dictionary {
            result += "\(key): \(value)\n"
        }
        
        let message = result.trimmingCharacters(in: .whitespacesAndNewlines)
        log(message, level: level, file: file, function: function, line: line)
    }
    
    static func error(_ message: String) {
        log(message, level: .error)
    }
    
    private static func formattedTimeStamp() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: Date())
    }
}
