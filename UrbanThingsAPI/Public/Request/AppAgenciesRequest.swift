//
//  AppAgenciesRequest.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 08/08/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

/// Defines a transit agencies request for a list of transit agencies
public protocol AppAgenciesRequest: Request {

    associatedtype Result = [Agency]

    var areaFilter: AreaFilter? { get }
}

/// Default parser to convert a JSON response into an array of `TransitStop` objects.
///
///  - parameters:
///    - json: JSON object to parse.
///    - logger: Logger instance for any logging messages that may be output.
///  - returns: An array of `TransitStop` objects
///  - throws: `Error.JSONParseError` if unable to parse the input correctly
public func urbanThingsParser(json: AnyObject?, logger: Logger) throws -> [Agency] {
    return try [UTAgency](required: json).map { $0 as Agency }
}

/// Default parser to convert a JSON response into an array of `ImportSource` objects.
///
///  - parameters:
///    - json: JSON object to parse.
///    - logger: Logger instance for any logging messages that may be output.
///  - returns: An array of `ImportSource` objects
///  - throws: `Error.JSONParseError` if unable to parse the input correctly
public func urbanThingsParser(json: AnyObject?, logger: Logger) throws -> AppAgenciesResponse {
    return try UTAppAgenciesResponse(required: json) as AppAgenciesResponse
}

public struct UTAppAgenciesRequest: AppAgenciesRequest {

    public typealias Result = AppAgenciesResponse
    public typealias Parser = (json: AnyObject?, logger: Logger) throws -> Result

    public let areaFilter: AreaFilter?

    /// Parser to use when processing response to the request
    public let parser: Parser

    public init(parser: Parser = urbanThingsParser) {
        self.init(filter: nil, parser: parser)
    }

    /// Initialize an instance of `UTAppAgenciesRequest` with a circular area.
    ///
    ///  - parameters:
    ///    - center: The center geo-coordinates of the circular area.
    ///    - radius: The radius from the center point in metres.
    ///    - parser: Optional custom parser to process the response from the server. If omitted standard parser will be used.
    public init(center: Location, radius: UInt, parser: Parser = urbanThingsParser) {
        self.init(filter:AreaFilter.Circle(center, radius), parser: parser)
    }

    /// Initialize an instance of `UTPlacePointsRequest` with a rectangular area.
    ///
    ///  - parameters:
    ///    - topLeft: The top left geo-coordinates of the rectangular area.
    ///    - bottomRight: The bottom right geo-coordinates of the rectangular area.
    ///    - parser: Optional custom parser to process the response from the server. If omitted standard parser will be used.
    public init(topLeft: Location, bottomRight: Location, parser: Parser = urbanThingsParser) {
        self.init(filter:AreaFilter.Rectangle(topLeft, bottomRight), parser: parser)
    }

    private init(filter: AreaFilter?, parser: Parser) {
        self.areaFilter = filter
        self.parser = parser
    }
}
