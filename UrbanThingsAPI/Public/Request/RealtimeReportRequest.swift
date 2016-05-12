//
//  RealtimeReportRequest.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 03/05/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

import Foundation

/// Defines the structure that provides parameters for realtime report requests made through the API.
///
/// You may use the provided default implementation of the protocol `UTRealtimeReportRequest` or provide
/// a separate implementation if desireable.
public protocol RealtimeReportRequest : Request {
    
    associatedtype Result = TransitStopRTIResponse
    
    /// Stop ID of the report being requested
    var stopID:String { get }
    /// The maximum number of items to include in the report
    var maximumItems:UInt? { get }
    /// The number of minutes into the future for which to return results.
    var lookAheadMinutes:UInt? { get }
}

/// Default implementation of `RealtimeReportRequest` protocol provided by the API as default means
/// of passing parameters to API request methods. You may provide your own implementation if needed to pass to the API
/// request methods.
public struct UTRealtimeReportRequest : RealtimeReportRequest {
    
    public typealias Result = TransitStopRTIResponse
    public typealias Parser = (json:AnyObject?, logger:Logger) throws -> Result

    /// Stop ID of the report being requested
    public let stopID:String
    /// The maximum number of items to include in the report
    public let maximumItems:UInt?
    /// The number of minutes into the future for which to return results.
    public let lookAheadMinutes:UInt?
    
    /// Parser to be used to process the response to the request.
    public let parser:Parser
    
    /// Initialization of request object to pass into the API method `getRealtimeReport`.
    /// - parameters:
    ///   - stopID: Stop ID of the report to be requested
    ///   - maximumItems: Maximum number of items to include in the report
    ///   - lookAheadMinutes: Number of minutes into the future for which to return results
    ///   - parser: Optional custom parser to process the response from the server. If omitted standard parser will be used.
    public init(stopID:String, maximumItems:UInt? = nil, lookAheadMinutes:UInt? = nil, parser:Parser = urbanThingsParser) {
        self.parser = parser
        self.stopID = stopID
        self.maximumItems = maximumItems
        self.lookAheadMinutes = lookAheadMinutes
    }
}