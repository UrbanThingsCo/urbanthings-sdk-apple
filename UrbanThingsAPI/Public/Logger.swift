//
//  Logger.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 10/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

/// Types of message that can be logged through the Logger protocol
public enum LoggerLevel {
    /// Error level indicates a serious problem
    case Error
    /// Warning level indicates warning
    case Warning
    /// Info level is for general information
    case Info
    /// Debug is for messages relevant to debugging
    case Debug
}

/// Protocol defining object providing logging method. If provided to an `UrbanThingsAPI` instance will be called with all
/// instrumentation messages from the framework giving client opportunity to provide their own logging mechanism.
public protocol Logger {
    /// Log a message at Info level
    ///  - parameters:
    ///    - message: Message string to be logged
    func log(message:String)
    
    /// Log a message
    ///  - parameters:
    ///    - level: Level of message
    ///    - message: Message string to be logged
    func log(level:LoggerLevel, _ message:String)
}

/// UTLogger is the standard logger provided by the API framework. An instance will be used by the API object
/// if no custom logger provided when instantiating the API instance.
public struct UTLogger : Logger {
    public func log(message:String) { log(.Info, message) }
    public func log(level:LoggerLevel, _ message:String) {
        #if !DEBUG
            if level == .Debug {
                return
            }
        #endif
        NSLog("\(level) \(message)")
    }
}
