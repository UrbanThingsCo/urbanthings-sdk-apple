//
//  TransitTripGroupsRequest.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 08/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

/// Defines the structure that provides parameters for transit trip group requests made through the API.
///
/// You may use the provided default implementation of the protocol `TransitTripsRequest` or provide
/// a separate implementation if desireable.
public protocol TransitTripGroupsRequest: GetRequest {

    associatedtype Result = [TransitTripCalendarGroup]

    /// Route ID to make request for.
    var routeID: String { get }
    /// If set to `true`, each `TransitTrip` object will have its polyline field populated with the street-level
    /// route geometry for the trip - this can increase response time and response size.
    var includePolylines: Bool { get }
    /// If set to `true`, each `TransitStopScheduledCallSummary` will include the latitude and longitude of the
    /// stop - this can increase response size.
    var includeStopCoordinates: Bool { get }
}

/// Defines the structure that provides parameters for transit trip requests made through the API.
///
/// You may use the provided default implementation of the protocol `TransitTripsRequest` or provide
/// a separate implementation if desireable.
public struct UTTransitTripGroupRequest: TransitTripGroupsRequest {

    public typealias Result = [TransitTripCalendarGroup]
    public typealias Parser = (json: AnyObject?, logger: Logger) throws -> Result
    public let endpoint = "static/tripgroups/bycalendar"

    /// Route ID to make request for.
    public let routeID: String
    /// If set to `true`, each `TransitTrip` object will have its polyline field populated with the street-level
    /// route geometry for the trip - this can increase response time and response size.
    public let includePolylines: Bool
    /// If set to `true`, each `TransitStopScheduledCallSummary` will include the latitude and longitude of the
    /// stop - this can increase response size.
    public let includeStopCoordinates: Bool

    /// Parser to use when processing response to the request
    public let parser: Parser

    /// Initialize an instance of `UTTransitTripGroupRequest`.
    ///
    /// - parameters:
    ///   - routeID: Route ID to make request for.
    ///   - includePolylines: If set to `true`, each `TransitTrip` object will have its polyline field populated with the street-level
    /// route geometry for the trip - this can increase response time and response size.
    ///   - includeStopCoordinates: If set to `true`, each `TransitStopScheduledCallSummary` will include the latitude and longitude of the
    /// stop - this can increase response size.
    ///   - parser: Optional custom parser to process the response from the server. If omitted standard parser will be used.
    public init(routeID: String, includePolylines: Bool = false, includeStopCoordinates: Bool = false, parser: Parser = urbanThingsParser) {
        self.parser = parser
        self.routeID = routeID
        self.includePolylines = includePolylines
        self.includeStopCoordinates = includeStopCoordinates
    }
}
