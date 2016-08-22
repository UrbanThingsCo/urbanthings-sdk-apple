//
//  Bool+JSON.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 28/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

/// Extend `Bool` to support JSONInitialization protocol for JSON parsing.
extension Bool : JSONInitialization {
    /// Initializer to parse JSON object into `Bool`. A result is required and so if
    /// input is nil, or not parsable as `Bool` an error is thrown.
    ///  - parameters:
    ///    - required: Input JSON object that is required to be parsed into a `Bool`.
    ///  - throws: Error.JSONParseError if unable to parse into `Bool`.
    public init(required:AnyObject?) throws {
        guard let value = required as? Bool else {
            throw Error(expected:Bool.self, not:required, file:#file, function:#function, line:#line)
        }
        self = value
    }

    /// Optional initializer to parse JSON object into `Bool`. If
    /// input is nil a nil optional results otherwise if not parsable as `Bool` an error is thrown.
    ///  - parameters:
    ///    - optional: Input JSON object that is to be parsed into a `Bool`.
    ///  - throws: Error.JSONParseError if unable to parse non-nil input into `Bool`.
    public init?(optional:AnyObject?) throws {
        guard optional != nil else {
            return nil
        }
        try self.init(required:optional)
    }
}
