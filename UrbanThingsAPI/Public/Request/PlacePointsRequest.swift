//
//  PlacePointsRequest.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 28/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation
import CoreLocation

/// Defines the structure that provides parameters for place point requests made through the API.
///
/// You may use the provided default implementation of the protocol `PlacePointsRequest` or provide
/// a separate implementation if desireable.
public protocol PlacePointsRequest: GetRequest {

    associatedtype Result = PlacePointList

    /// Defines the geographical area of the search.
    var area: AreaFilter { get }
    /// Maximum number of results, if not provided defaults to 1000.
    var maximumResults: UInt? { get }
    /// Optional name of a placepoint(s) to filter the results list by.
    var name: String? { get }
    /// An optional list of PlacePointTypes to filter the results by.
    var placepointTypes: [PlacePointType]? { get }
}

/// Default implementation of `PlacePointsRequestType` protocol provided by the API as default means
/// of passing parameters to API request methods. You may provide your own implementation if needed to pass to the API
/// request methods.
public struct UTPlacePointsRequest: PlacePointsRequest {

    public typealias Result = PlacePointList
    public typealias Parser = (json: AnyObject?, logger: Logger) throws -> Result
    public let endpoint = "static/placepoints"

    /// Defines the geographical area of the search.
    public let area: AreaFilter
    /// Maximum number of results, if not provided defaults to 1000.
    public let maximumResults: UInt?
    /// Optional name of a placepoint(s) to filter the results list by.
    public let name: String?
    /// An optional list of PlacePointTypes to filter the results by.
    public let placepointTypes: [PlacePointType]?

    /// Parser to be used to process the response to the request.
    public let parser: Parser

    /// Initialize an instance of `UTPlacePointsRequest` with a circular area.
    ///
    ///  - parameters:
    ///    - center: The center geo-coordinates of the circular area.
    ///    - radius: The radius from the center point in metres.
    ///    - name: Optional name of a placepoint(s) to filter the results list by.
    ///    - placepointTypes: An optional list of PlacePointTypes to filter the results by.
    ///    - maximumResults: Maximum number of results, if not provided defaults to 1000.
    ///    - parser: Optional custom parser to process the response from the server. If omitted standard parser will be used.
    public init(center: Location, radius: UInt, name: String? = nil, placepointTypes: [PlacePointType]? = nil, maximumResults: UInt? = nil, parser: Parser = urbanThingsParser) {
        self.init(filter:AreaFilter.Circle(center, radius), name:name, placepointTypes:placepointTypes, maximumResults: maximumResults, parser: parser)
    }

    /// Initialize an instance of `UTPlacePointsRequest` with a rectangular area.
    ///
    ///  - parameters:
    ///    - topLeft: The top left geo-coordinates of the rectangular area.
    ///    - bottomRight: The bottom right geo-coordinates of the rectangular area.
    ///    - name: Optional name of a placepoint(s) to filter the results list by.
    ///    - placepointTypes: An optional list of PlacePointTypes to filter the results by.
    ///    - maximumResults: Maximum number of results, if not provided defaults to 1000.
    ///    - parser: Optional custom parser to process the response from the server. If omitted standard parser will be used.
    public init(topLeft: Location, bottomRight: Location, name: String? = nil, placepointTypes: [PlacePointType]? = nil, importSource: String? = nil, maximumResults: UInt? = nil, parser: Parser = urbanThingsParser) {
        self.init(filter:AreaFilter.Rectangle(topLeft, bottomRight), name:name, placepointTypes:placepointTypes, maximumResults: maximumResults, parser: parser)
    }

    init(filter: AreaFilter, name: String? = nil, placepointTypes: [PlacePointType]? = nil, maximumResults: UInt? = nil, parser: Parser = urbanThingsParser) {
        self.parser = parser
        self.area = filter
        self.maximumResults = maximumResults
        self.name = name
        self.placepointTypes = placepointTypes
    }
}
