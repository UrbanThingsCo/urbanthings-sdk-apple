//
//  TransitRoutesByStopRequest.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 08/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

/// Defines request for routes that include a given stop ID
public protocol TransitRoutesByStopRequest : Request {
    
    associatedtype Result = [TransitDetailedRouteInfo]

    /// Transit stop ID to get routes for
    var stopID:String { get }
}

/// Default implementation of `TransitRoutesByStopRequest` protocol provided by the API as default means
/// of passing parameters to API request methods. You may provide your own implementation if needed to pass to the API
/// request methods.
public struct UTTransitRoutesByStopRequest : TransitRoutesByStopRequest {
    
    public typealias Result = [TransitDetailedRouteInfo]
    public typealias Parser = (json:AnyObject?, logger:Logger) throws -> Result
    
    /// Transit stop ID to get routes for
    public let stopID:String
    
    /// Parser to use when processing response to the request
    public let parser:Parser
    
    /// Initialize an instance of `UTTransitRoutesByStopRequest`.
    ///
    /// - parameters:
    ///   - stopID: Transit stop ID to get routes for.
    ///   - parser: Optional custom parser to process the response from the server. If omitted standard parser will be used.
    public init(stopID:String, parser:Parser = urbanThingsParser) {
        self.stopID = stopID
        self.parser = parser
    }
}