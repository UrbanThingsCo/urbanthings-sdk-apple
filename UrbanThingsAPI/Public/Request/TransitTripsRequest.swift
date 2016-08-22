//
//  TransitTripsRequest.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 30/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

/// Defines ways of requesting a trip
public enum RouteOrTripID {
    /// Request by route ID
    case RouteID(String)
    /// Request by trip ID
    case TripID(String)
}

/// Defines the structure that provides parameters for transit trip requests made through the API.
///
/// You may use the provided default implementation of the protocol `TransitTripsRequest` or provide
/// a separate implementation if desireable.
public protocol TransitTripsRequest: GetRequest {

    associatedtype Result = [TransitTrip]

    /// Route or trip ID to base search on
    var routeOrTripID: RouteOrTripID { get }
    /// The primary code of an origin stop. Optionally used to restrict the range of the retrieved trip.
    var originStopID: String? { get }
    /// The primary code of a destination stop. Optionally used to restrict the range of the retrieved trip.
    var destinationStopID: String? { get }
    /// If set to `true`, each `TransitTrip` object will have its polyline field populated with the street-level
    /// route geometry for the trip - this can increase response time and response size.
    var includePolylines: Bool { get }
    /// If set to `true`, each `TransitStopScheduledCallSummary` will include the latitude and longitude of the
    /// stop - this can increase response size.
    var includeStopCoordinates: Bool { get }
}

/// Default implementation of `TransitTripsRequest` protocol provided by the API as default means
/// of passing parameters to API request methods. You may provide your own implementation if needed to pass to the API
/// request methods.
public struct UTTransitTripsRequest: TransitTripsRequest {

    public typealias Result = [TransitTrip]
    public typealias Parser = (json: AnyObject?, logger: Logger) throws -> Result
    public let endpoint = "static/trips"

    /// Route or trip ID to base search on
    public let routeOrTripID: RouteOrTripID
    /// The primary code of an origin stop. Optionally used to restrict the range of the retrieved trip.
    public let originStopID: String?
    /// The primary code of a destination stop. Optionally used to restrict the range of the retrieved trip.
    public let destinationStopID: String?
    /// If set to `true`, each `TransitTrip` object will have its polyline field populated with the street-level
    /// route geometry for the trip - this can increase response time and response size.
    public let includePolylines: Bool
    /// If set to `true`, each `TransitStopScheduledCallSummary` will include the latitude and longitude of the
    /// stop - this can increase response size.
    public let includeStopCoordinates: Bool

    /// Parser to use when processing response to the request
    public let parser: Parser

    /// Initialize an instance of `UTTransitTripsRequest` for a request based on trip ID.
    ///
    /// - parameters:
    ///   - tripID: The trip ID to make request for.
    ///   - originStopID: The primary code of an origin stop. Optionally used to restrict the range of the retrieved trip.
    ///   - destinationStopID: The primary code of a destination stop. Optionally used to restrict the range of the retrieved trip.
    ///   - includePolylines: If set to `true`, each `TransitTrip` object will have its polyline field populated with the street-level
    /// route geometry for the trip - this can increase response time and response size.
    ///   - includeStopCoordinates: If set to `true`, each `TransitStopScheduledCallSummary` will include the latitude and longitude of the
    /// stop - this can increase response size.
    ///   - parser: Optional custom parser to process the response from the server. If omitted standard parser will be used.
    public init(tripID: String, originStopID: String? = nil, destinationStopID: String? = nil, includePolylines: Bool = false, includeStopCoordinates: Bool = false, parser: Parser = urbanThingsParser) {
        self.init(routeOrTripID:RouteOrTripID.TripID(tripID),
                  originStopID: originStopID,
                  destinationStopID: destinationStopID,
                  includePolylines: includePolylines,
                  includeStopCoordinates: includeStopCoordinates)
    }

    /// Initialize an instance of `UTTransitTripsRequest` for a request based on route ID.
    ///
    /// - parameters:
    ///   - routeID: The route ID to make request for.
    ///   - originStopID: The primary code of an origin stop. Optionally used to restrict the range of the retrieved trip.
    ///   - destinationStopID: The primary code of a destination stop. Optionally used to restrict the range of the retrieved trip.
    ///   - includePolylines: If set to `true`, each `TransitTrip` object will have its polyline field populated with the street-level
    /// route geometry for the trip - this can increase response time and response size.
    ///   - includeStopCoordinates: If set to `true`, each `TransitStopScheduledCallSummary` will include the latitude and longitude of the
    /// stop - this can increase response size.
    ///   - parser: Optional custom parser to process the response from the server. If omitted standard parser will be used.
    public init(routeID: String, originStopID: String? = nil, destinationStopID: String? = nil, includePolylines: Bool = false, includeStopCoordinates: Bool = false, parser: Parser = urbanThingsParser) {
        self.init(routeOrTripID:RouteOrTripID.RouteID(routeID),
                  originStopID: originStopID,
                  destinationStopID: destinationStopID,
                  includePolylines: includePolylines,
                  includeStopCoordinates: includeStopCoordinates)
    }

    init(routeOrTripID: RouteOrTripID, originStopID: String? = nil, destinationStopID: String? = nil, includePolylines: Bool = false, includeStopCoordinates: Bool = false, parser: Parser = urbanThingsParser) {
        self.parser = parser
        self.routeOrTripID = routeOrTripID
        self.originStopID = originStopID
        self.destinationStopID = destinationStopID
        self.includePolylines = includePolylines
        self.includeStopCoordinates = includeStopCoordinates
    }
}
