//
//  RealtimeResourcesStatusRequest.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 08/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

/// Defines a resource status request for a a list of resources
public protocol RealtimeResourcesStatusRequest: GetRequest {

    associatedtype Result = [ResourceStatus]

    /// Array of stop IDs to obtain resource status for.
    var stopIDs: [String] { get }
}

/// Default implementation of `UTRealtimeResourcesStatusRequest` protocol provided by the API as standard means
/// of passing parameters to API request methods. You may provide your own implementation if needed to pass to the API
/// request methods.
public struct UTRealtimeResourcesStatusRequest: RealtimeResourcesStatusRequest {

    public typealias Result = [ResourceStatus]
    public typealias Parser = (json: AnyObject?, logger: Logger) throws -> Result
    public let endpoint = "rti/resources/status"

    /// Array of stop IDs to obtain resource status for.
    public let stopIDs: [String]

    /// Parser to use when processing response to the request
    public let parser: Parser

    /// Initialize instance of `UTRealtimeResourcesStatusRequest`.
    ///
    /// - parameters:
    ///   - stopIDs: An array of stop IDs to obtain resource status for.
    ///   - parser: Optional custom parser to process the response from the server. If omitted standard parser will be used.
    public init(stopIDs: [String], parser: Parser = urbanThingsParser) {
        self.parser = parser
        self.stopIDs = stopIDs
    }
}
