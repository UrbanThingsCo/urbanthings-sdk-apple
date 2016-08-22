//
//  TransitStopsRequest.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 28/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation
import CoreLocation

/// Defines the structure that provides parameters for transit stop requests made through the API.
///
/// You may use the provided default implementation of the protocol `TransitStopRequests` or provide
/// a separate implementation if desireable.
public protocol TransitStopsRequest: GetRequest {

    associatedtype Result = [TransitStop]

    /// Defines the geographical area of the search.
    var area: AreaFilter { get }
    /// Maximum number of results, if not provided defaults to 1000.
    var maximumResults: UInt? { get }
    /// The name of particular transit stop(s) to search for. Specify six or more characters. Searches are case insensitive.
    var stopName: String? { get }
    /// An optional list of stop modes used to filter the list of `TransitStop`s returned.
    var stopModes: [TransitMode]? { get }
    /// An optional list of primary codes of transit stops to search for.
    var stopIDs: [String]? { get }
    /// Optionally filter the returned list to include only `TransitStop`s with this ImportSource ID.
    var importSource: String? { get }
}

/// Default implementation of `TransitStopsRequestType` protocol provided by the API as default means
/// of passing parameters to API request methods. You may provide your own implementation if needed to pass to the API
/// request methods.
public struct UTTransitStopsRequest: TransitStopsRequest {

    public typealias Result = [TransitStop]
    public typealias Parser = (json: AnyObject?, logger: Logger) throws -> Result
    public let endpoint = "static/transitstops"

    /// Defines the geographical area of the search.
    public let area: AreaFilter
    /// Maximum number of results, if not provided defaults to 1000.
    public let maximumResults: UInt?
    /// The name of particular transit stop(s) to search for. Specify six or more characters. Searches are case insensitive.
    public let stopName: String?
    /// An optional list of stop modes used to filter the list of `TransitStop`s returned.
    public let stopModes: [TransitMode]?
    /// An optional list of primary codes of transit stops to search for.
    public let stopIDs: [String]?
    /// Optionally filter the returned list to include only `TransitStop`s with this ImportSource ID.
    public let importSource: String?

    /// Parser to use when processing response to the request
    public let parser: Parser

    /// Initialize an instance of `UTTransitStopsRequest` limited to a cirular geographic area.
    ///
    /// - parameters:
    ///   - center: Center location for request.
    ///   - radius: Radius for request in metres.
    ///   - stopName: Optional mame of stop to search for.
    ///   - stopModes: Optional list of transit modes to limit search to.
    ///   - stopIDs: Optional list of stop IDs to limit search to.
    ///   - importSource: Optional import source to limit search to.
    ///   - maximumResults: Optional maximum number of results to return, defaults to 1000.
    ///   - parser: Optional custom parser to process the response from the server. If omitted standard parser will be used.
    public init(center: Location, radius: UInt, stopName: String? = nil, stopModes: [TransitMode]? = nil, stopIDs: [String]? = nil, importSource: String? = nil, maximumResults: UInt? = nil, parser: Parser = urbanThingsParser) {
        self.init(filter:AreaFilter.Circle(center, radius), stopName:stopName, stopModes:stopModes, stopIDs:stopIDs, importSource:importSource, maximumResults: maximumResults, parser: parser)
    }

    /// Initialize an instance of `UTTransitStopsRequest` limited to a rectangular geographical area.
    ///
    /// - parameters:
    ///   - topLeft: Geo-coordinate of top left of search rectangle
    ///   - bottomRight: Geo-coordinate of bottom right of search rectangle
    ///   - stopName: Optional mame of stop to search for.
    ///   - stopModes: Optional list of transit modes to limit search to.
    ///   - stopIDs: Optional list of stop IDs to limit search to.
    ///   - importSource: Optional import source to limit search to.
    ///   - maximumResults: Optional maximum number of results to return, defaults to 1000.
    ///   - parser: Optional custom parser to process the response from the server. If omitted standard parser will be used.
    public init(topLeft: Location, bottomRight: Location, stopName: String? = nil, stopModes: [TransitMode]? = nil, stopIDs: [String]? = nil, importSource: String? = nil, maximumResults: UInt? = nil, parser: Parser = urbanThingsParser) {
        self.init(filter:AreaFilter.Rectangle(topLeft, bottomRight), stopName:stopName, stopModes:stopModes, stopIDs:stopIDs, importSource:importSource, maximumResults: maximumResults, parser: parser)
    }

    init(filter: AreaFilter, stopName: String? = nil, stopModes: [TransitMode]? = nil, stopIDs: [String]? = nil, importSource: String? = nil, maximumResults: UInt? = nil, parser: Parser = urbanThingsParser) {
        self.parser = parser
        self.area = filter
        self.maximumResults = maximumResults
        self.stopName = stopName
        self.stopModes = stopModes
        self.stopIDs = stopIDs
        self.importSource = importSource
    }
}
