//
//  Logger.swift
//  Networking
//
//  Created by Nagaraj Rao on 25/05/24.
//

import Foundation

public protocol Logger {
    func log(_ message: String)
}

public struct ConsoleLogger: Logger {
    public init() {}
    public func log(_ message: String) {
        print(message)
    }
}
