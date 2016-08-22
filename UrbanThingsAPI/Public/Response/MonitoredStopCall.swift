//
//  MonitoredStopCall.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 26/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

/// Defines how arrival at stop is displayed
@objc public enum MonitoredStopCallDisplayFormat:Int {
    /// Display time until arrival at stop
    case Time = 0
    /// Display distance from stop
    case Distance = 1
}

/// `MonitoredStopCall` contains realtime information for a timetabled call at a transit stop.
public protocol MonitoredStopCall : StopCall {
    /// The real time estimate of when this vehicle is expected to arrive at the stop.
    var expectedArrivalTime:NSDate? { get }
    /// The real time estimate of when this vehicle is expected to depart from the stop.
    var expectedDepartureTime:NSDate? { get }
    /// The real time estimate of the distance from the stop, along the route, that the vehicle is presently located at.
    var distanceMetres:Int? { get }
    /// A value to aid presentation; this indicates whether a time based or distance based display is most appropriate.
    var masterDisplayFormat:MonitoredStopCallDisplayFormat { get }
    /// Any additional Real Time information for this vehicle - the delay field is not relevant in this context.
    var vehicleRTI:VehicleRTI { get }
    /// A label representing the platform at which the vehicle is expected to call when it arrives at this stop if applicable.
    var platform:String? { get }
    /// A flag to indicate if the vehicle's trip has been cancelled. If this is set to TRUE any conflicting real time information should be discarded.
    var isCancelled:Bool { get }
}

extension MonitoredStopCallDisplayFormat : JSONInitialization {
    
    public init(required:AnyObject?) throws {
        guard let rawValue = required as? Int else {
            throw Error(expected: Int.self, not: required, file:#file, function:#function, line:#line)
        }
        guard let value = MonitoredStopCallDisplayFormat(rawValue:rawValue) else {
            throw Error(enumType: MonitoredStopCallDisplayFormat.self, invalidRawValue: rawValue, file:#file, function:#function, line:#line)
        }
        self = value
    }
    
    public init?(optional:AnyObject?) throws {
        guard optional != nil else {
            return nil
        }
        try self.init(required: optional)
    }
}