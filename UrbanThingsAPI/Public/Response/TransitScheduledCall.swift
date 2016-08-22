//
//  TransitScheduledCall.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 29/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

/// `TransitCallType` details the types of transit call that can be made.
public enum TransitCallType:Int {
    /// A regularly scheduled call.
    case RegularlyScheduled = 0
    /// The call is not avaialble
    case NotAvailable = 1
    /// Call transit agency to arrange a pickup or dropoff at this scheduled call stop.
    case PhoneAgencyToArrange = 2
    /// Make arrangements with the driver of the vehicle.
    case ArrangeWithDriver = 3
}

/// `TransitScheduledCall` details a single scheduled call at a transit stop.
public protocol TransitScheduledCall {
    /// The scheduled arrival time of the vehicle, if available.
    var scheduledArrivalTime:NSDate? { get }
    /// The scheduled departure time of the vehicle, if available.
    var scheduledDepartureTime:NSDate? { get }
    /// How the vehicle picks up passengers at this stop, if at all. See GTFS specification. Note - if this value is omitted, the default value of `RegularlyScheduled` should be assumed
    var pickupType:TransitCallType? { get }
    /// How the vehicle drops off passengers at this stop, if at all. See GTFS specification. Note - if this value is omitted, the default value of `RegularlyScheduled` should be assumed
    var dropoffType:TransitCallType? { get }
}

extension TransitCallType : JSONInitialization {
    public init(required:AnyObject?) throws {
        guard let raw = required as? Int else {
            throw Error(expected: Int.self, not: required, file:#file, function:#function, line:#line)
        }
        guard let call = TransitCallType(rawValue:raw) else {
            throw Error(enumType: TransitCallType.self, invalidRawValue: raw, file:#file, function:#function, line:#line)
        }
        self = call
    }
    
    public init?(optional:AnyObject?) throws {
        guard optional != nil else {
            return nil
        }
        try self.init(required:optional)
    }
}