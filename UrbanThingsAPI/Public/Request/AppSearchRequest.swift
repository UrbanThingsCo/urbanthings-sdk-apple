//
//  AppSearch.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 02/08/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

/// Defines a transit agencies request for a list of transit agencies
public protocol AppSearchRequest: Request {

    associatedtype Result = AppSearchResponse

    var query: String { get }
    var location: Location { get }
}

/// Default parser to convert a JSON response into an array of `ImportSource` objects.
///
///  - parameters:
///    - json: JSON object to parse.
///    - logger: Logger instance for any logging messages that may be output.
///  - returns: An array of `ImportSource` objects
///  - throws: `Error.JSONParseError` if unable to parse the input correctly
public func urbanThingsParser(json: AnyObject?, logger: Logger) throws -> AppSearchResponse {
    return try UTAppSearchResponse(required: json) as AppSearchResponse
}

public struct UTAppSearchRequest: AppSearchRequest {

    public typealias Result = AppSearchResponse
    public typealias Parser = (json: AnyObject?, logger: Logger) throws -> Result

    public let query: String
    public let location: Location

    /// Parser to use when processing response to the request
    public let parser: Parser

    public init(query: String, location: Location, parser: Parser = urbanThingsParser) {
        self.query = query
        self.location = location
        self.parser = parser
    }
}
