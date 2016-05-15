//
//  TransitAgencyRequest.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 08/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

/// Defines a request for a transit agency.
public protocol TransitAgencyRequest : Request {
    
    associatedtype Result = TransitAgency

    /// The agency ID for the transit agency to fetch data for.
    var agencyID:String { get }
}

/// Default implementation of `TransitAgencyRequest` protocol provided by the API as standard means
/// of passing parameters to API request methods. You may provide your own implementation if needed to pass to the API
/// request methods.
public struct UTTransitAgencyRequest : TransitAgencyRequest {
    
    public typealias Result = TransitAgency
    public typealias Parser = (json:AnyObject?, logger:Logger) throws -> Result
    
    /// The agency ID for the transit agency to fetch data for.
    public let agencyID:String
    
    /// Parser to use when processing response to the request
    public let parser:Parser
    
    /// Initialize an instance of `UTTransitAgencyRequest`
    /// - parameters:
    ///   - agencyID: The agency ID for the transit agency to fetch data for.
    ///   - parser: Optional custom parser to process the response from the server. If omitted standard parser will be used.
    public init(agencyID:String, parser:Parser = urbanThingsParser) {
        self.parser = parser
        self.agencyID = agencyID
    }
}