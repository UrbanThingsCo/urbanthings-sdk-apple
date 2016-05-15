//
//  TransitRoutesByImportSourceRequest.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 28/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

/// Defines the source for transit route request
public enum TransitRoutesImportSource {
    /// Specified using an agency ID
    case AgencyID(String)
    /// Specified by import source
    case ImportSource(String)
}

/// Defines a request for a transit route information.
public protocol TransitRoutesByImportSourceRequest : Request {
    
    associatedtype Result = [TransitDetailedRouteInfo]

    /// Source for transit routes
    var source:TransitRoutesImportSource { get }
    
}

/// Default implementation of `TransitRoutesByImportSourceRequest` protocol provided by the API as standard means
/// of passing parameters to API request methods. You may provide your own implementation if needed to pass to the API
/// request methods.
public struct UTTransitRoutesByImportSourceRequest : TransitRoutesByImportSourceRequest {
    
    public typealias Result = [TransitDetailedRouteInfo]
    public typealias Parser = (json:AnyObject?, logger:Logger) throws -> Result

    /// Source for transit routes
    public let source:TransitRoutesImportSource
    
    /// Parser to use when processing response to the request
    public let parser:Parser

    /// Initialize an instance of `UTTransitRoutesByImportSourceRequest`
    /// - parameters:
    ///   - agencyID: The agency ID for the transit agency to fetch data for.
    ///   - parser: Optional custom parser to process the response from the server. If omitted standard parser will be used.
    public init(agencyID:String, parser:Parser = urbanThingsParser) {
        self.parser = parser
        self.source = .AgencyID(agencyID)
    }
    
    /// Initialize an instance of `UTTransitRoutesByImportSourceRequest`
    /// - parameters:
    ///   - importSource: The import source to fetch data for.
    ///   - parser: Optional custom parser to process the response from the server. If omitted standard parser will be used.
    public init(importSource:String, parser:Parser = urbanThingsParser) {
        self.parser = parser
        self.source = .ImportSource(importSource)
    }
}
