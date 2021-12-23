//
//  OSLog.swift
//
//  Created by dwKang on 2021/06/19.
//

import Foundation
import os.log

extension OSLog {

//    ## Check
//    Console App > 동작 > 정보 메시지 포함

    static var subsystem = Bundle.main.bundleIdentifier!

    static let info = OSLog(subsystem: subsystem, category: ":::🔵")
    static let debug = OSLog(subsystem: subsystem, category: ":::🟢")
    static let warning = OSLog(subsystem: subsystem, category: ":::🟠")
    static let error = OSLog(subsystem: subsystem, category: ":::🔴")
}


struct Log {
    
    enum Level {
        case info
        case error
        case debug
        case warning

        fileprivate var category: String {
            switch self {
            case .info:
                return ":::🟢"
            case .error:
                return ":::🔴"
            case .debug:
                return ":::🔵"
            case .warning:
                return ":::🟠"
            }
        }

        fileprivate var osLog: OSLog {
            switch self {
            case .info:
                return OSLog.info
            case .error:
                return OSLog.error
            case .debug:
                return OSLog.debug
            case .warning:
                return OSLog.warning
            }
        }

        fileprivate var osLogType: OSLogType {
            switch self {
            case .info:
                return .info
            case .error:
                return .error
            case .debug:
                return .debug
            case .warning:
                return .default
            }
        }
    }

    static private func log(_ message: Any, _ arguments: [Any], level: Level) {
        #if DEBUG
        if #available(iOS 14.0, *) {
            let extraMessage: String = arguments.map({ String(describing: ": \($0)") }).joined(separator: " ")
            let logger = Logger(subsystem: OSLog.subsystem, category: level.category)
            let logMessage = "\(message)\(extraMessage)"
            switch level {
            case .info:
                logger.info("\(logMessage, privacy: .public)")
            case .error:
                logger.error("\(logMessage, privacy: .public)")
            case .debug:
                logger.debug("\(logMessage, privacy: .public)")
            case .warning:
                logger.warning("\(logMessage, privacy: .public)")
            }
        } else {
            let extraMessage: String = arguments.map({ String(describing: ": \($0)") }).joined(separator: " ")
            os_log("%{public}@", log: level.osLog, type: level.osLogType, "\(message)\(extraMessage)")
        }
        #endif
    }
}


// MARK: - utils
extension Log {

    static func info(_ message: Any, _ arguments: Any..., filename: String = #file, line: Int = #line) {
        log("\(filename.components(separatedBy: "/").last ?? "")(\(line)) - \(message)", arguments, level: .info)
    }

    static func error(_ message: Any, _ arguments: Any..., filename: String = #file, line: Int = #line) {
        log("\(filename.components(separatedBy: "/").last ?? "")(\(line)) - \(message)", arguments, level: .error)
    }
    
    static func debug(_ message: Any, _ arguments: Any..., filename: String = #file, line: Int = #line) {
        log("\(filename.components(separatedBy: "/").last ?? "")(\(line)) - \(message)", arguments, level: .debug)
    }
    
    static func warning(_ message: Any, _ arguments: Any..., filename: String = #file, line: Int = #line) {
        log("\(filename.components(separatedBy: "/").last ?? "")(\(line)) - \(message)", arguments, level: .warning)
    }
}
