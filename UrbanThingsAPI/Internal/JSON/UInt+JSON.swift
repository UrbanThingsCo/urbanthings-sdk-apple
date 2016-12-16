//
//  UInt+JSON.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 29/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

/// Extend `UInt` to support JSONInitialization protocol for JSON parsing.
extension UInt : JSONInitialization {
    
    /// Initializer to parse JSON object into `UInt`. A result is required and so if
    /// input is nil, or not parsable as `Bool` an error is thrown.
    ///  - parameters:
    ///    - required: Input JSON object that is required to be parsed into a `UInt`.
    ///  - throws: Error.JSONParseError if unable to parse into `Uint`.
    public init(required:Any?) throws {
        guard let value = required as? UInt else {
            throw UTAPIError(expected:UInt.self, not:required, file:#file, function:#function, line:#line)
        }
        self = value
    }
    
    public init?(optional:Any?) throws {
        guard optional != nil else {
            return nil
        }
        try self.init(required: optional)
    }
}
