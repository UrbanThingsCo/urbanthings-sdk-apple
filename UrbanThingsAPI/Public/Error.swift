//
//  UrbanThingsError.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 28/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

/// ErrorType enum defining possible error states from the API framework
public enum Error : ErrorType {

    /// API reported some error in processing the request
    case APIError(message:String?)
    /// An error occurred parsing the JSON payload in the response. This should not occur and indicates a bug either in the
    /// API framework or the server side API. Details of the issue in the first string parameter and debug info int the
    /// second. If you experience this error please report to apisupport@urbanthings.io giving as much detail as you can.
    case JSONParseError(message:String, debugInfo:String)
    /// A HTTP failure code was returned, with optional informational message
    case HTTPStatusError(code:Int, message:String?)
    /// Some unexpected condition occurred, details in the first string parameter with debug info in the second.
    /// If you experience this error please report to apisupport@urbanthings.io giving as much detail as you can.
    case Unexpected(message:String, debugInfo:String)
    /// Error that is re-throwing some other error
    case Rethrown(message:String, innerError:ErrorType)
}
