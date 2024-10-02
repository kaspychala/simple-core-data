//
//  LoggingManager.swift
//  SimpleCoreData
//
//  Created by Kasper Spychala on 02/10/2024.
//

import SwiftyBeaver

protocol LoggingManagerProtocol {
    func debug(_ message: String)
    func info(_ message: String)
    func warning(_ message: String)
    func error(_ message: String)
}

class LoggingManager: LoggingManagerProtocol {
    static let shared: LoggingManagerProtocol = LoggingManager()

    private let log = SwiftyBeaver.self

    private init() {
        let console = ConsoleDestination()
        console.minLevel = .debug
        log.addDestination(console)
    }

    func debug(_ message: String) {
        log.debug(message)
    }

    func info(_ message: String) {
        log.info(message)
    }

    func warning(_ message: String) {
        log.warning(message)
    }

    func error(_ message: String) {
        log.error(message)
    }
}
