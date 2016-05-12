//
//  TransitMode+JSON.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 28/04/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

import Foundation

/// Extend `TransitMode` enum to support JSONInitialization protocol for JSON parsing.
extension TransitMode : JSONInitialization {
    
    init?(optional:AnyObject?) throws {
        guard optional != nil else {
            return nil
        }
        try self.init(required: optional)
    }
    
    /// Initializer to parse JSON object into `TransitMode`. A result is required and so if
    /// input is nil, or not parsable as `Bool` an error is thrown.
    ///  - parameters:
    ///    - required: Input JSON object that is required to be parsed into a `TransitMode`.
    ///  - throws: Error.JSONParseError if unable to parse into `TransitMode`.
    init(required:AnyObject?) throws {
        guard let rawValue = required as? Int else {
            throw Error(expected:Int.self, not:required, file:#file, function:#function, line:#line)
        }
        guard let value = TransitMode(rawValue:rawValue) else {
            throw Error(enumType: TransitMode.self, invalidRawValue: rawValue, file:#file, function:#function, line:#line)
        }
        
        self = value
    }
}