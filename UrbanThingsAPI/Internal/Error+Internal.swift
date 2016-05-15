//
//  Error.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 07/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

let ReportErrorMessage = "This should not have occurred, please report to apisupport@urbanthings.io giving as much detail as you can."

extension Error : CustomStringConvertible {
    public var description:String {
        switch self {
        case .APIError(let message):
            return "API response error - \(message ?? "Unknown error")"
        case .JSONParseError(let message, let debug):
            return "Error parsing JSON @ \(debug) - \(message). \(ReportErrorMessage)"
        case .HTTPStatusError(let code, let message):
            return "HTTP Error \(code) - \(message ?? NSHTTPURLResponse.localizedStringForStatusCode(code))"
        case .Unexpected(let message, let debug):
            return "Unexpected error @ \(debug) - \(message). \(ReportErrorMessage)"
        case .Rethrown(let message, let inner):
            return "\(message). Inner error: \(inner)"
        }
    }
}

// Extend Error with initializers for specific message cases
extension Error {
    
    /// Constructs Error for a JSON parsing error.
    ///  - parameters:
    ///    - jsonParseError: Descriptive string for the error
    ///    - file: Filename path, use #file for this parameter
    ///    - function: Function name, use #function for this parameter or provide other string detailing function or class information
    ///    - line: Line number of error, use #line for this parameter
    init(jsonParseError:String, file:String, function:String, line:Int) {
        self = .JSONParseError(message: jsonParseError, debugInfo: Error.debugInfoString(file, function: function, line: line))
    }
    
    /// Constructs Error for an unexpected error
    ///  - parameters:
    ///    - unexpected: Descriptive string for the error
    ///    - file: Filename path, use #file for this parameter
    ///    - function: Function name, use #function for this parameter or provide other string detailing function or class information
    ///    - line: Line number of error, use #line for this parameter
    init(unexpected:String, file:String, function:String, line:Int) {
        self = .Unexpected(message: unexpected, debugInfo: Error.debugInfoString(file, function: function, line: line))
    }
    
    /// Constructs Error for unexpected input value for JSON parsing
    ///  - parameters:
    ///    - expected: Type expected
    ///    - not: Instance received that is not of expected type
    ///    - file: Filename path, use #file for this parameter
    ///    - function: Function name, use #function for this parameter or provide other string detailing function or class information
    ///    - line: Line number of error, use #line for this parameter
    init<T>(expected:T.Type, not:AnyObject?, file:String, function:String, line:Int) {
        self.init(jsonParseError:"Expected \(expected) value, not \(not)", file:file, function:function, line:line)
    }
    
    /// Constructs Error for invalid raw value when parsing JSON to enum type
    ///  - parameters:
    ///    - enumType: Type of enum being parsed
    ///    - invalidRawValue: Raw value parsed from JSON that is not valid for the enum type
    ///    - file: Filename path, use #file for this parameter
    ///    - function: Function name, use #function for this parameter or provide other string detailing function or class information
    ///    - line: Line number of error, use #line for this parameter
    init<T>(enumType:T.Type, invalidRawValue:Int, file:String, function:String, line:Int) {
        self.init(jsonParseError:"Invalid \(enumType) raw value \(invalidRawValue)", file:#file, function:#function, line:#line)
    }
    
    /// Constructs a string for debug purposes including bundle name, version, source file line number and function.
    ///  - parameters:
    ///    - file: Filename path, use #file for this parameter
    ///    - function: Function name, use #function for this parameter or provide other string detailing function or class information
    ///    - line: Line number of error, use #line for this parameter
    private static func debugInfoString(file:String, function:String, line:Int) -> String {
        let bundle = NSBundle(forClass: UrbanThingsAPI.self)
        let name = bundle.objectForInfoDictionaryKey("CFBundleName") ?? "#missing#"
        let version = bundle.objectForInfoDictionaryKey("CFBundleShortVersionString") ?? "#missing#"
        let build = bundle.objectForInfoDictionaryKey("CFBundleVersion") ?? "#missing#"
        return "\(name!) \(version!)(\(build!)) \((file as NSString).lastPathComponent) \(function):\(line)"
    }
}