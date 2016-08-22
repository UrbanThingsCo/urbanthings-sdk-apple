//
//  TransitStopCallsRequest.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 30/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

/// Defines the structure that provides parameters for static stop calls requests made through the API.
///
/// You may use the provided default implementation of the protocol `UTTransitStopCallsRequest` or provide
/// a separate implementation if desireable.
public protocol TransitStopCallsRequest: GetRequest {

    associatedtype Result = TransitStopScheduledCalls

    /// The primary code of the stop to retrieve a timetable for.
    var stopID: String { get }
    /// The point in time at which to produce a timetable for, defaults to now.
    var queryTime: NSDate? { get }
    /// The number of minutes beyond the queryTime for which to return results, defaults to 2 hours.
    var lookAheadMinutes: Int? { get }
}

/// Default implementation of `TransitStopCallsRequest` protocol provided by the API as default means
/// of passing parameters to API request methods. You may provide your own implementation if needed to pass to the API
/// request methods.
public struct UTTransitStopCallsRequest: TransitStopCallsRequest {

    public typealias Result = TransitStopScheduledCalls
    public typealias Parser = (json: AnyObject?, logger: Logger) throws -> Result
    public let endpoint = "static/stopcalls"

    /// The primary code of the stop to retrieve a timetable for.
    public let stopID: String
    /// The point in time at which to produce a timetable for, defaults to now.
    public let queryTime: NSDate?
    /// The number of minutes beyond the queryTime for which to return results, defaults to 2 hours.
    public let lookAheadMinutes: Int?

    /// Parser to use when processing response to the request
    public var parser: Parser

    /// Initialization of request object to pass into the API method `getStopCalls`.
    ///
    /// - parameters:
    ///   - stopID: Stop ID of stop that stop calls request is for
    ///   - queryTime: Point of time to produce the report for, defaults to now.
    ///   - lookAheadMinutes: The number of minutes beyond the queryTime for which to return results. Defaults to 2 hours.
    ///   - parser: Optional custom parser to process the response from the server. If omitted standard parser will be used.
    public init(stopID: String, queryTime: NSDate? = nil, lookAheadMinutes: Int? = nil, parser: Parser = urbanThingsParser) {
        self.parser = parser
        self.stopID = stopID
        self.queryTime = queryTime
        self.lookAheadMinutes = lookAheadMinutes
    }
}
