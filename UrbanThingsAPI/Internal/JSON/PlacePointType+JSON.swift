//
//  PlacePointType+JSON.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 28/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation


/// Extend `PlacePointType` enum to support JSONInitialization protocol for JSON parsing.
extension PlacePointType : JSONInitialization {

    /// Initializer to parse JSON object into `PlacePointType`. A result is required and so if
    /// input is nil, or not parsable as `Bool` an error is thrown.
    ///  - parameters:
    ///    - required: Input JSON object that is required to be parsed into a `PlacePointType`.
    ///  - throws: Error.JSONParseError if unable to parse into `PlacePointType`.
    public init(required:AnyObject?) throws {
        guard let rawValue = required as? Int else {
            throw Error(expected:Int.self, not:required, file:#file, function:#function, line:#line)
        }
        guard let value = PlacePointType(rawValue:rawValue) else {
            throw Error(enumType: PlacePointType.self, invalidRawValue: rawValue, file:#file, function:#function, line:#line)
        }
        self = value
    }
    
    public init?(optional:AnyObject?) throws {
        guard let rawValue = optional as? Int else {
            return nil
        }
        try self.init(required: rawValue)
    }
}