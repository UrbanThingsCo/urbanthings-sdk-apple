//
//  TransitScheduledCall.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 15/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation
import UTAPI

/// `TransitCallType` details the types of transit call that can be made.
@objc public enum TransitCallType:Int {
    /// A regularly scheduled call.
    case RegularlyScheduled = 0
    /// The call is not avaialble
    case NotAvailable = 1
    /// Call transit agency to arrange a pickup or dropoff at this scheduled call stop.
    case PhoneAgencyToArrange = 2
    /// Make arrangements with the driver of the vehicle.
    case ArrangeWithDriver = 3
    case Unknown = -1
    
    init(_ value: UTAPI.TransitCallType?) {
        self = TransitCallType(rawValue: value?.rawValue ?? -1) ?? .Unknown
    }
}

@objc public protocol TransitScheduledCall {
    /// The scheduled arrival time of the vehicle, if available.
    var scheduledArrivalTime:NSDate? { get }
    /// The scheduled departure time of the vehicle, if available.
    var scheduledDepartureTime:NSDate? { get }
    /// How the vehicle picks up passengers at this stop, if at all. See GTFS specification. Note - if this value is omitted, the default value of `RegularlyScheduled` should be assumed
    var pickupType:TransitCallType { get }
    /// How the vehicle drops off passengers at this stop, if at all. See GTFS specification. Note - if this value is omitted, the default value of `RegularlyScheduled` should be assumed
    var dropoffType:TransitCallType { get }
}

@objc public class UTTransitScheduledCall : NSObject, TransitScheduledCall {
    
    let adapted:UTAPI.TransitScheduledCall
    
    public init(adapt: UTAPI.TransitScheduledCall) {
        self.adapted = adapt
        self.pickupType = TransitCallType(adapt.pickupType)
        self.dropoffType = TransitCallType(adapt.dropoffType)
    }

    public var scheduledArrivalTime: NSDate? { return self.adapted.scheduledArrivalTime }
    public var scheduledDepartureTime: NSDate? { return self.adapted.scheduledDepartureTime }
    public let pickupType: TransitCallType
    public let dropoffType: TransitCallType
}
