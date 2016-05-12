//
//  PlacesListRequest.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 28/04/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

import Foundation
import CoreLocation

/// Defines the structure that provides parameters for places list requests made through the API.
///
/// You may use the provided default implementation of the protocol `UTPlacesListRequest` or provide
/// a separate implementation if desireable.
public protocol PlacesListRequest : Request {
    
    associatedtype Result = PlacePointList

    /// The name of the item being searched for.
    var name:String { get }
    /// Location to base search from, either geo location point (with optional country code), or just a country code
    var location:LocationFilter { get }
    /// Optional list of place point types to search for
    var placePointTypes:[PlacePointType]? { get }
    /// The maximum number of results of each PlacePointType to return. This cannot be more than 40. Defaults to 6.
    var maximumResultsPerType:UInt? { get }
}

/// Default implementation of `PlacesListRequestType` protocol provided by the API as default means
/// of passing parameters to API request methods. You may provide your own implementation if needed to pass to the API
/// request methods.
public struct UTPlacesListRequest : PlacesListRequest {
    
    public typealias Result = PlacePointList
    public typealias Parser = (json:AnyObject?, logger:Logger) throws -> Result

    /// The name of the item being searched for.
    public let name:String
    /// Location to base search from, either geo location point (with optional country code), or just a country code
    public let location:LocationFilter
    /// Optional list of place point types to search for
    public let placePointTypes:[PlacePointType]?
    /// The maximum number of results of each PlacePointType to return. This cannot be more than 40. Defaults to 6.
    public let maximumResultsPerType:UInt?
    
    /// Parser to be used to process the response to the request.
    public let parser:Parser

    /// Initialize an instance of `UTPlacesListRequest` with location based filtering.
    ///
    ///  - parameters:
    ///    - name: Name to search for.
    ///    - location: The location to center search around.
    ///    - country: Optional optional country to limit search to.
    ///    - placePointTypes: Optional list of place point types to search for.
    ///    - parser: Optional custom parser to process the response from the server. If omitted standard parser will be used.
    public init(name:String, location:CLLocationCoordinate2D, country:String? = nil, placePointTypes:[PlacePointType]? = nil, maximumResultsPerType:UInt? = nil, parser:Parser = urbanThingsParser) {
        self.init(name:name, location:LocationFilter.Point(location, country), placePointTypes: placePointTypes, maximumResultsPerType: maximumResultsPerType, parser:parser)
    }

    /// Initialize an instance of `UTPlacesListRequest` with country based filtering.
    ///
    ///  - parameters:
    ///    - name: Name to search for.
    ///    - country: Optional optional country to limit search to.
    ///    - placePointTypes: Optional list of place point types to search for.
    ///    - parser: Optional custom parser to process the response from the server. If omitted standard parser will be used.
    public init(name:String, country:String, placePointTypes:[PlacePointType]? = nil, maximumResultsPerType:UInt? = nil, parser:Parser = urbanThingsParser) {
        self.init(name:name, location:LocationFilter.Country(country), placePointTypes: placePointTypes, maximumResultsPerType: maximumResultsPerType, parser:parser)
    }
    
    init(name:String, location:LocationFilter, placePointTypes:[PlacePointType]? = nil, maximumResultsPerType:UInt? = nil, parser:Parser = urbanThingsParser) {
        self.parser = parser
        self.name = name
        self.location = location
        self.placePointTypes = placePointTypes
        self.maximumResultsPerType = maximumResultsPerType
    }
}