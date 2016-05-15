//
//  ResourceTrend+JSON.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 04/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

/// Extend `ResourceTrend` enum to support JSONInitialization protocol for JSON parsing.
extension ResourceTrend : JSONInitialization {
    
    init?(optional:AnyObject?) throws {
        guard optional != nil else {
            return nil
        }
        try self.init(required: optional)
    }
    
    /// Initializer to parse JSON object into `ResourceTrend`. A result is required and so if
    /// input is nil, or not parsable as `Bool` an error is thrown.
    ///  - parameters:
    ///    - required: Input JSON object that is required to be parsed into a `ResourceTrend`.
    ///  - throws: Error.JSONParseError if unable to parse into `ResourceTrend`.
    init(required:AnyObject?) throws {
        guard let rawValue = required as? Int else {
            throw Error(expected:Int.self, not:required, file:#file, function:#function, line:#line)
        }
        guard let value = ResourceTrend(rawValue:rawValue) else {
            throw Error(enumType: ResourceTrend.self, invalidRawValue: rawValue, file:#file, function:#function, line:#line)
        }
        
        self = value
    }

}