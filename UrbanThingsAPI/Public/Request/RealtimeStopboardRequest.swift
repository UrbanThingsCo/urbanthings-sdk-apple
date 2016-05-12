//
//  RealtimeStopboardRequest.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 03/05/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

import Foundation

/// Defines types of passing vehicle to include in realtime stopboard request.
public enum VehiclePassing: Int {
    /// All vehicles
    case AllVehicles = 0
    /// Vehicles that terminate at the stop
    case TerminatingHereOnly = 1
    /// Vehicles that do not terminate at the stop
    case AllExceptTerminatingHere = 2
    /// Vehicles that start at the stop
    case StartingHereOnly = 3
}

extension VehiclePassing : CustomStringConvertible {
    public var description:String {
        switch self {
        case .AllVehicles:
            return "AllVehicles"
        case .TerminatingHereOnly:
            return "TerminatingHereOnly"
        case .AllExceptTerminatingHere:
            return "AllExceptTerminatingHere"
        case .StartingHereOnly:
            return "StartingHereOnly"
        }
    }
}

/// Defines the structure that provides parameters for realtime stopboard requests made through the API.
///
/// You may use the provided default implementation of the protocol `UTRealtimeStopboardRequest` or provide
/// a separate implementation if needed.
/// ````
/// let api = UTUrbanThingsAPI(apiKey:APIKey)
/// let _ = api.sendRequest(UTRealtimeStopboardRequest(
///                 stopID: aStopID) 
/// { data:StopBoardResponse?, error:Error in
///     // Process data or handle error
/// }
/// ````
public protocol RealtimeStopboardRequest : Request {
    
    associatedtype Result = StopBoardResponse
    
    /// Stop ID of the stop board information required
    var stopID:String { get }
    /// Used when necessary to specify an 'Arrivals', 'Departure' or mixed type of board. Mainly relevant to trains.
    var vehiclePassingType:VehiclePassing { get }
    /// The maximum number of StopBoardRows to return in the StopBoard
    var maximumItems:UInt? { get }
    /// Whether or not to return time strings in 12 or 24 hour format
    var use24HourClock:Bool { get }
}

/// Default implementation of `RealtimeStopboardRequest` protocol provided by the API as standard means
/// of passing parameters to API request methods. You may provide your own implementation if needed to pass to the API
/// request methods.
public struct UTRealtimeStopboardRequest : RealtimeStopboardRequest {
    
    public typealias Result = StopBoardResponse
    public typealias Parser = (json:AnyObject?, logger:Logger) throws -> Result

    /// Stop ID of the stop board information required
    public let stopID:String
    /// Used when necessary to specify an 'Arrivals', 'Departure' or mixed type of board. Mainly relevant to trains.
    public let vehiclePassingType:VehiclePassing
    /// The maximum number of StopBoardRows to return in the StopBoard
    public let maximumItems:UInt?
    /// Whether or not to return time strings in 12 or 24 hour format
    public let use24HourClock:Bool
    
    /// Parser to use when processing response to the request
    public let parser:Parser
    
    /// Initialization of request object to pass into the API `sendRequest` method. A basic request provides
    /// the required stopID parameter. More complex requests can provide additional options along with a custom parser
    /// if a different means of processing the response JSON into an object that implements the `StopBoardResponse`.
    ///
    /// ````
    /// let basicRequest = UTRealtimeStopboardRequest(
    ///                             stopID:"123")
    ///
    /// let complexRequest = UTRealtimeStopboardRequest(
    ///                             stopID:"123",
    ///                             vehiclePassingType:.Bus, 
    ///                             use24HourClock = false, 
    ///                             maximumItems: 100, 
    ///                             parser: myCustomParserFunc)
    /// ````
    ///
    /// - parameters:
    ///   - stopID: Stop ID of the stop board to be requested.
    ///   - vehiclePassingType: Limit results to type of passing vehicle. Used when necessary to specify an 'Arrivals', 'Departure' or mixed type of board, mainly relevent to trains. Default value `.AllVehicles`.
    ///   - use24HourClock: Indicates whether returned result time strings should be in 12 or 24 hour format. Defaults to the format of the current locale for the app.
    ///   - maximumItems: Maximum number of rows to include in the results set for a stop board.
    ///   - parser: Optional custom parser to process the response from the server. If omitted standard parser will be used.
    public init(stopID:String, vehiclePassingType:VehiclePassing = .AllVehicles, use24HourClock:Bool? = nil, maximumItems:UInt? = nil, parser:Parser = urbanThingsParser) {
        self.parser = parser
        self.stopID = stopID
        self.vehiclePassingType = vehiclePassingType
        self.use24HourClock = use24HourClock ?? NSLocale.currentLocale().localeIs24HourClockFormat
        self.maximumItems = maximumItems
    }
}

// Extension to NSLocale to determine whether the locale by default formats times in 24 or 12 hour format
extension NSLocale {
    var localeIs24HourClockFormat:Bool {
        return NSDateFormatter.dateFormatFromTemplate("j", options: 0, locale: self) == "HH"
    }
}

