//
//  Array+JSON.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 01/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

/// Extension to Array to allow parsing of JSON array into a dictionary of parsed objects. Elements of the resulting array must
/// support the JSONInitialization protocol.
extension Array where Element : JSONInitialization {
    
    /// Initialize an array of objects from a JSON object.
    ///  - parameters:
    ///    - required: Object to be parsed into array. This should be an array of AnyObject or will throw.
    ///  - throws: Error.JSONParseError if unable to provide a parsed array result
    init(required:AnyObject?) throws {
        guard let array = required as? [AnyObject] else {
            throw Error(expected: [AnyObject].self, not: required, file:#file, function:#function, line:#line)
        }
        self.init()
        self.appendContentsOf(try array.map { try Element(required: $0) })
    }
    
    /// Initialize an array of objects from a JSON object. If passed nil will initialize to `Optional(nil)` instance, otherwise if unable
    /// to parse `optional` to an array of `Element` throws.
    ///  - parameters:
    ///    - optional: Object to be parsed into array, if nil will initialize to `Optional(nil)`. If non-nil will throw if unable to parse.
    ///  - throws: Error.JSONParseError if unable to provide a parsed array result and `optional` non-nil.
    init?(optional:AnyObject?) throws {
        guard optional != nil else {
            return nil
        }
        try self.init(required: optional)
    }
}