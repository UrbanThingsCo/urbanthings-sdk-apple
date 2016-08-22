//
//  Int+JSON.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 02/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

/// Extend `Int` to support JSONInitialization protocol for JSON parsing.
extension Int : JSONInitialization {

    /// Initializer to parse JSON object into `Int`. A result is required and so if
    /// input is nil, or not parsable as `Int` an error is thrown.
    ///  - parameters:
    ///    - required: Input JSON object that is required to be parsed into a `Int`.
    ///  - throws: Error.JSONParseError if unable to parse into `Int`.
    public init(required:AnyObject?) throws {
        guard let value = required as? Int else {
            throw Error(expected:Int.self, not:required, file:#file, function:#function, line:#line)
        }
        self = value
    }
    
    public init?(optional:AnyObject?) throws {
        guard optional != nil else {
            return nil
        }
        try self.init(required: optional)
    }
}
