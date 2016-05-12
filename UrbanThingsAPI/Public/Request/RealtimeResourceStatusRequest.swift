//
//  RealtimeResourceStatusRequest.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 08/05/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

import Foundation

/// Defines a resource status request for a single resource
public protocol RealtimeResourceStatusRequest : Request {
    
    associatedtype Result = ResourceStatus
    
    /// Stop Id of the resource that status is being requested for.
    var stopID:String { get }
}

/// Default implementation of `RealtimeResourceStatusRequest` protocol provided by the API as standard means
/// of passing parameters to API request methods. You may provide your own implementation if needed to pass to the API
/// request methods.
public struct UTRealtimeResourceStatusRequest : RealtimeResourceStatusRequest {
    
    public typealias Result = ResourceStatus
    public typealias Parser = (json:AnyObject?, logger:Logger) throws -> Result

    /// Stop Id of the resource that status is being requested for.
    public let stopID:String
    
    /// Parser to use when processing response to the request
    public let parser:Parser
    
    /// Initialize instance of `UTRealtimeResourceStatusRequest`.
    ///
    /// - parameters:
    ///   - stopID: The stop ID to request status for.
    ///   - parser: Optional custom parser to process the response from the server. If omitted standard parser will be used.
    public init(stopID:String, parser:Parser = urbanThingsParser) {
        self.parser = parser
        self.stopID = stopID
    }
}