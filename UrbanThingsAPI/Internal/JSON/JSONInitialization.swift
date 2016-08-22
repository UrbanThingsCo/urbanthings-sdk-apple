//
//  JSONInitialization.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 02/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

/// Protocol to be implemented by items that are parseable from JSON. `AnyObject` in this case is any
/// valid object in graph returned by `NSJSONSerialization.JSONObjectWithData` class method.
public protocol JSONInitialization {
    /// Parse input into instance of type implementing the protocol. A result is required and so if
    /// input is nil, or not parsable into the required type an error is thrown.
    ///  - parameters:
    ///    - required: Input JSON object that is required to be parsed into instance of type.
    ///  - throws: Error.JSONParseError if unable to parse into instance of type.
    init(required: AnyObject?) throws

    /// Parse input into optional instance of type implementing the protocol. A nil optional will result if
    /// nil is passed in as `optional`. If none nil `optional` passed and an instance of the type cannot be
    /// parsed an error is thrown.
    ///  - parameters:
    ///    - required: Input JSON object that is required to be parsed into instance of type.
    ///  - throws: Error.JSONParseError if unable to parse into instance of type.
    init?(optional: AnyObject?) throws
}
