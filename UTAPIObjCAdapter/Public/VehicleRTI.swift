//
//  VehicleRTI.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 15/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation
import UTAPI

@objc public protocol VehicleRTI {
    /// The unique identifier of the Agency operating this vehicle. If the information comes from our systems, a corresponding
    /// `TransitAgency` object will exist with this ID.
    var agencyCode:String? { get }
    /// In some systems this ID allows the vehicle to be uniquely identified.
    var vehicleID:String { get }
    ///  Inidcates how late, or early, the vehicle is presently running. A value of nil indicates no available data.
    var delayOffsetMinutes:Int { get }
    /// The vehicle registration number, as publicly displayed.
    var vehicleRegistrationCode:String? { get }
    /// Indicates whether the capacity and occupancy data is valid
    var hasCapacityData:Bool { get }
    /// The number of passengers that this vehicle is able to carry, if avialable.
    var vehicleCapacityTotalPassengers:UInt { get }
    /// The number of passengers presently on board this vehicle, if available.
    var vehicleOccupancyPassengers:UInt { get }
    /// Indicates whether the vehicle been cancelled (either in advance, or en-route)
    var isCancelled:TriState { get }
}

@objc public class UTVehicleRTI : NSObject, VehicleRTI {
    
    let adapted:UTAPI.VehicleRTI
    
    public init(adapt:UTAPI.VehicleRTI) {
        self.adapted = adapt
    }
    
    public var agencyCode:String? { return self.adapted.agencyCode }
    public var vehicleID:String { return self.adapted.vehicleID }
    public var delayOffsetMinutes:Int { return self.adapted.delayOffsetMinutes ?? 0 }
    public var vehicleRegistrationCode:String? { return self.adapted.vehicleRegistrationCode }
    public var hasCapacityData:Bool { return self.adapted.vehicleCapacityTotalPassengers != nil && self.adapted.vehicleOccupancyPassengers != nil }
    public var vehicleCapacityTotalPassengers:UInt { return self.adapted.vehicleCapacityTotalPassengers ?? 0 }
    public var vehicleOccupancyPassengers:UInt { return self.adapted.vehicleCapacityTotalPassengers ?? 0 }
    public var isCancelled:TriState { return TriState(self.adapted.isCancelled) }
}
