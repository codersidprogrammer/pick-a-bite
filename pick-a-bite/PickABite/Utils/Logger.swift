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
    static func log(_ message: String, level: LogLevel = .info) {
        let timestamp = formattedTimeStamp()
        print("\(timestamp) \(level.rawValue) \(message)")
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
