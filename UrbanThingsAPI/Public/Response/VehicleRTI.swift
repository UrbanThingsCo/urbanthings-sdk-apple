//
//  VehicleRTI.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 26/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

/// `VehicleRTI` provides realtime information about a vehicle.
public protocol VehicleRTI {
    /// The unique identifier of the Agency operating this vehicle. If the information comes from our systems, a corresponding 
    /// `TransitAgency` object will exist with this ID.
    var agencyCode:String? { get }
    /// In some systems this ID allows the vehicle to be uniquely identified.
    var vehicleID:String { get }
    ///  Inidcates how late, or early, the vehicle is presently running. A value of nil indicates no available data.
    var delayOffsetMinutes:Int? { get }
    /// The vehicle registration number, as publicly displayed.
    var vehicleRegistrationCode:String? { get }
    /// The number of passengers that this vehicle is able to carry, if avialable.
    var vehicleCapacityTotalPassengers:UInt? { get }
    /// The number of passengers presently on board this vehicle, if available.
    var vehicleOccupancyPassengers:UInt? { get }
    /// Indicates whether the vehicle been cancelled (either in advance, or en-route)
    var isCancelled:Bool? { get }
}