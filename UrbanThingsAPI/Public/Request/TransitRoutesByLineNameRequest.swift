//
//  TransitRoutesByLineNameRequest.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 28/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation
import CoreLocation

/// Defines different valid combinations of required parameters
public enum TransitRoutesByLineRequiredParameters {
    /// Specify request by location and optionally agency ID and import source
    case Location(CLLocationCoordinate2D, String?, String?)
    /// Specify request by agency ID and optionally location and import source
    case AgencyID(String, CLLocationCoordinate2D?, String?)
    /// Specify request by import source and optionally location and agency ID
    case ImportSource(String, CLLocationCoordinate2D?, String?)
}

/// Defines the structure that provides parameters for transit route requests for line name made through the API.
///
/// You may use the provided default implementation of the protocol `UTTransitRouteLineNameRequest` or provide
/// a separate implementation if desireable.
public protocol TransitRoutesByLineNameRequest : Request {
    
    associatedtype Result = [TransitDetailedRouteInfo]

    /// Line name to request routes for
    var lineName:String { get }
    /// Additional parameters needed for request
    var requiredParameters:TransitRoutesByLineRequiredParameters { get }
    /// Indicates whether an exact match is needed or not
    var exactMatch:Bool? { get }
    /// Additional optional limit by agency region
    var agencyRegion:String? { get }
}

/// Default implementation of `TransitRouteLineNameRequest` protocol provided by the API as default means
/// of passing parameters to API request methods. You may provide your own implementation if needed to pass to the API
/// request methods.
public struct UTTransitRoutesByLineNameRequest : TransitRoutesByLineNameRequest {
    
    public typealias Result = [TransitDetailedRouteInfo]
    public typealias Parser = (json:AnyObject?, logger:Logger) throws -> Result

    /// Line name to request routes for
    public let lineName:String
    /// Additional parameters needed for request
    public let requiredParameters:TransitRoutesByLineRequiredParameters
    /// Indicates whether an exact match is needed or not
    public let exactMatch:Bool?
    /// Additional optional limit by agency region
    public let agencyRegion:String?
    
    /// Parser to use when processing response to the request
    public let parser:Parser

    /// Initialize a request based on name and location within a country
    ///
    /// - parameters:
    ///   - lineName: Name of line to make request for
    ///   - location: Location to make request for
    ///   - agencyID: Optional agency ID to include in request
    ///   - importSource: Optional import source to include in request
    ///   - agencyRegion: Optional agency region to include in request
    ///   - parser: Optional custom parser to process the response from the server. If omitted standard parser will be used.
    public init(lineName:String, location:CLLocationCoordinate2D, agencyID:String? = nil, importSource:String? = nil, agencyRegion:String? = nil, exactMatch:Bool? = nil, parser:Parser = urbanThingsParser) {
        self.init(lineName:lineName, requiredParameters: .Location(location, agencyID, importSource), agencyRegion: agencyRegion, exactMatch: exactMatch)
    }
    
    /// Initialize a request based on name and agency ID
    ///
    /// - parameters:
    ///   - lineName: Name of line to make request for
    ///   - agencyID: Agency ID to include in request
    ///   - location: Optional ;ocation to make request for
    ///   - importSource: Optional import source to include in request
    ///   - agencyRegion: Optional agency region to include in request
    ///   - parser: Optional custom parser to process the response from the server. If omitted standard parser will be used.
    public init(lineName:String, agencyID:String, location:CLLocationCoordinate2D? = nil, importSource:String? = nil, agencyRegion:String? = nil, exactMatch:Bool? = nil, parser:Parser = urbanThingsParser) {
        self.init(lineName:lineName, requiredParameters: .AgencyID(agencyID, location, importSource), agencyRegion: agencyRegion, exactMatch: exactMatch)
    }
    
    /// Initialize a request based on name and agency ID
    ///
    /// - parameters:
    ///   - lineName: Name of line to make request for
    ///   - importSource: Import source to include in request
    ///   - location: Optional location to make request for
    ///   - agencyID: Optional agency ID to include in request
    ///   - agencyRegion: Optional agency region to include in request
    ///   - parser: Optional custom parser to process the response from the server. If omitted standard parser will be used.
    public init(lineName:String, importSource:String, location:CLLocationCoordinate2D? = nil, agencyID:String? = nil, agencyRegion:String? = nil, exactMatch:Bool? = nil, parser:Parser = urbanThingsParser) {
        self.init(lineName:lineName, requiredParameters: .ImportSource(importSource, location, agencyID), agencyRegion: agencyRegion, exactMatch: exactMatch)
    }
    
    init(lineName:String, requiredParameters:TransitRoutesByLineRequiredParameters, agencyRegion:String? = nil, exactMatch:Bool? = nil, parser:Parser = urbanThingsParser) {
        self.parser = parser
        self.lineName = lineName
        self.requiredParameters = requiredParameters
        self.agencyRegion = agencyRegion
        self.exactMatch = exactMatch
    }
}

