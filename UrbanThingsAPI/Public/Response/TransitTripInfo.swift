//
//  TransitTripInfo.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 26/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

/// `TransitTripInfo` provides basic details about a transit trip.
public protocol TransitTripInfo {
    /// A unique identifier representing the agency that operates this trip.
    var agencyCode:String? { get }
    /// A unique code that represents this trip. Note that IDs in some regions may change periodically and thus should not be stored on the client.
    var tripID:String? { get }
    /// The name of the origin stop on this trip.
    var originName:String? { get }
    /// The primary code of the origin stop on this trip.
    var originPrimaryCode:String? { get }
    /// The name of the ultimate destination on this trip.
    var headsign:String? { get }
    /// A descriptive name for the direction travelled on this trip, with relation to the route - e.g. 'Outbound'. Does not apply to all transit modes.
    var directionName:String? { get }
    /// A numeric identifier for the direction travelled on this trip, with relation to the route. e.g. A bus route may designate one direction as 'outbound' (1) and another direction as 'inbound' (2). Does not apply to all transit modes.
    var directionID:UInt? { get }
    /// The ID of the vehicle scheduled to make the trip. This may or may not be the same as the VehicleID that is assigned when the vehicle actually runs (see VehicleRTI)
    var vehicleID:String? { get }
    /// Whether this trip is accessible to wheelchair users. This information may not be available in some data sets.
    var isWheelchairAccessible: Bool? { get }
}