//
//  Parsers.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 08/05/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

import Foundation


/// Default parser to convert a JSON response into an array of `ImportSource` objects.
///
///  - parameters:
///    - json: JSON object to parse.
///    - logger: Logger instance for any logging messages that may be output.
///  - returns: An array of `ImportSource` objects
///  - throws: `Error.JSONParseError` if unable to parse the input correctly
public func urbanThingsParser(json:AnyObject?, logger:Logger) throws -> [ImportSource] {
    return try [UTImportSource](required: json).map { $0 as ImportSource }
}

/// Default parser to convert a JSON response into an array of `TransitStop` objects.
///
///  - parameters:
///    - json: JSON object to parse.
///    - logger: Logger instance for any logging messages that may be output.
///  - returns: An array of `TransitStop` objects
///  - throws: `Error.JSONParseError` if unable to parse the input correctly
public func urbanThingsParser(json:AnyObject?, logger:Logger) throws -> [TransitStop] {
    return try [UTTransitStop](required: json).map { $0 as TransitStop }
}

/// Default parser to convert a JSON response into an array of `TransitDetailedRouteInfo` objects.
///
///  - parameters:
///    - json: JSON object to parse.
///    - logger: Logger instance for any logging messages that may be output.
///  - returns: An array of `TransitDetailedRouteInfo` objects
///  - throws: `Error.JSONParseError` if unable to parse the input correctly
public func urbanThingsParser(json:AnyObject?, logger:Logger) throws -> [TransitDetailedRouteInfo] {
    return try [UTTransitDetailedRouteInfo](required: json).map { $0 as TransitDetailedRouteInfo }
}

/// Default parser to convert a JSON response into an array of `TransitDetailedRouteInfo` objects.
///
///  - parameters:
///    - json: JSON object to parse.
///    - logger: Logger instance for any logging messages that may be output.
///  - returns: An array of `TransitDetailedRouteInfo` objects.
///  - throws: `Error.JSONParseError` if unable to parse the input correctly.
public func urbanThingsParser(json:AnyObject?, logger:Logger) throws -> [TransitTrip] {
    return try [UTTransitTrip](required: json).map { $0 as TransitTrip }
}

/// Default parser to convert a JSON response into a  `PlacePointList` object.
///
///  - parameters:
///    - json: JSON object to parse.
///    - logger: Logger instance for any logging messages that may be output.
///  - returns: Instance of `PlacePointList` object.
///  - throws: `Error.JSONParseError` if unable to parse the input correctly
public func urbanThingsParser(json:AnyObject?, logger:Logger) throws -> PlacePointList {
    return try UTPlacePointList(required: json)
}

/// Default parser to convert a JSON response into a  `TransitAgency` object.
///
///  - parameters:
///    - json: JSON object to parse.
///    - logger: Logger instance for any logging messages that may be output.
///  - returns: Instance of `TransitAgency` object.
///  - throws: `Error.JSONParseError` if unable to parse the input correctly
public func urbanThingsParser(json:AnyObject?, logger:Logger) throws -> TransitAgency {
    let array:[TransitAgency] = try urbanThingsParser(json, logger: logger)
    guard array.count == 1 else {
        throw Error.init(jsonParseError: "Expected [TransitAgency] array with exactly one element", file: #file, function: #function, line: #line)
    }
    return array[0]
}

/// Default parser to convert a JSON response into an array of `TransitAgency` objects.
///
///  - parameters:
///    - json: JSON object to parse.
///    - logger: Logger instance for any logging messages that may be output.
///  - returns: An array of `TransitAgency` objects.
///  - throws: `Error.JSONParseError` if unable to parse the input correctly.
public func urbanThingsParser(json:AnyObject?, logger:Logger) throws -> [TransitAgency] {
    return try [UTTransitAgency](required: json).map { $0 as TransitAgency }
}

/// Default parser to convert a JSON response into a  `TransitStopScheduledCalls` object.
///
///  - parameters:
///    - json: JSON object to parse.
///    - logger: Logger instance for any logging messages that may be output.
///  - returns: Instance of `TransitStopScheduledCalls` object.
///  - throws: `Error.JSONParseError` if unable to parse the input correctly
public func urbanThingsParser(json:AnyObject?, logger:Logger) throws -> TransitStopScheduledCalls {
    return try UTTransitStopScheduledCalls(required: json)
}

/// Default parser to convert a JSON response into an array of `TransitTripCalendarGroup` objects.
///
///  - parameters:
///    - json: JSON object to parse.
///    - logger: Logger instance for any logging messages that may be output.
///  - returns: An array of `TransitTripCalendarGroup` objects.
///  - throws: `Error.JSONParseError` if unable to parse the input correctly.
public func urbanThingsParser(json:AnyObject?, logger:Logger) throws -> [TransitTripCalendarGroup] {
    return try [UTTransitTripCalendarGroup](required: json).map { $0 as TransitTripCalendarGroup }
}

/// Default parser to convert a JSON response into a  `TransitStopRTIResponse` object.
///
///  - parameters:
///    - json: JSON object to parse.
///    - logger: Logger instance for any logging messages that may be output.
///  - returns: Instance of `TransitStopRTIResponse` object.
///  - throws: `Error.JSONParseError` if unable to parse the input correctly
public func urbanThingsParser(json:AnyObject?, logger:Logger) throws -> TransitStopRTIResponse {
    return try UTTransitStopRTIResponse(required: json)
}

/// Default parser to convert a JSON response into a  `StopBoardResponse` object.
///
///  - parameters:
///    - json: JSON object to parse.
///    - logger: Logger instance for any logging messages that may be output.
///  - returns: Instance of `StopBoardResponse` object.
///  - throws: `Error.JSONParseError` if unable to parse the input correctly
public func urbanThingsParser(json:AnyObject?, logger:Logger) throws -> StopBoardResponse {
    return try UTStopBoardResponse(required: json)
}

/// Default parser to convert a JSON response into an array of `ResourceStatus` objects.
///
///  - parameters:
///    - json: JSON object to parse.
///    - logger: Logger instance for any logging messages that may be output.
///  - returns: An array of `ResourceStatus` objects.
///  - throws: `Error.JSONParseError` if unable to parse the input correctly.
public func urbanThingsParser(json:AnyObject?, logger:Logger) throws -> [ResourceStatus] {
    return try [UTResourceStatus](required: json).map { $0 as ResourceStatus }
}

/// Default parser to convert a JSON response into a  `ResourceStatus` object.
///
///  - parameters:
///    - json: JSON object to parse.
///    - logger: Logger instance for any logging messages that may be output.
///  - returns: Instance of `ResourceStatus` object.
///  - throws: `Error.JSONParseError` if unable to parse the input correctly
public func urbanThingsParser(json:AnyObject?, logger:Logger) throws -> ResourceStatus {
    let array:[ResourceStatus] = try urbanThingsParser(json, logger: logger)
    guard array.count == 1 else {
        throw Error.init(jsonParseError: "Expected [ResourceStatus] array with exactly one element", file: #file, function: #function, line: #line)
    }
    return array[0]
}

/// Default parser to convert a JSON response into a  `DirectionsResponse` object.
///
///  - parameters:
///    - json: JSON object to parse.
///    - logger: Logger instance for any logging messages that may be output.
///  - returns: Instance of `DirectionsResponse` object.
///  - throws: `Error.JSONParseError` if unable to parse the input correctly
public func urbanThingsParser(json:AnyObject?, logger:Logger) throws -> DirectionsResponse {
    return try UTDirectionsResponse(required: json)
}
