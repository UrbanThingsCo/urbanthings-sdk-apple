//
//  TransitTripInfo.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 15/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation
import protocol UrbanThingsAPI.TransitTripInfo

@objc public protocol TransitTripInfo {
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
    var directionID:UInt { get }
    /// The ID of the vehicle scheduled to make the trip. This may or may not be the same as the VehicleID that is assigned when the vehicle actually runs (see VehicleRTI)
    var vehicleID:String? { get }
    /// Whether this trip is accessible to wheelchair users. This information may not be available in some data sets.
    var isWheelchairAccessible: TriState { get }
}

@objc public class UTTransitTripInfo : NSObject, TransitTripInfo {
    
    let adapted:UrbanThingsAPI.TransitTripInfo
    
    public init?(adapt:UrbanThingsAPI.TransitTripInfo?) {
        guard let adapt = adapt else {
            return nil
        }
        self.adapted = adapt
    }
    
    public var agencyCode:String? { return self.adapted.agencyCode }
    public var tripID:String? { return self.adapted.tripID }
    public var originName:String? { return self.adapted.originName }
    public var originPrimaryCode:String? { return self.adapted.originPrimaryCode }
    public var headsign:String? { return self.adapted.headsign }
    public var directionName:String? { return self.adapted.directionName }
    public var directionID:UInt { return self.adapted.directionID ?? 0}
    public var vehicleID:String? { return self.adapted.vehicleID }
    public var isWheelchairAccessible: TriState { return TriState(self.adapted.isWheelchairAccessible) }
}
