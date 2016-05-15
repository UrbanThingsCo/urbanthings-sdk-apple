//
//  VehicleRTI.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 15/05/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

import Foundation


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
    /// The number of passengers that this vehicle is able to carry, if avialable.
    var vehicleCapacityTotalPassengers:Int { get }
    /// The number of passengers presently on board this vehicle, if available.
    var vehicleOccupancyPassengers:Int { get }
    /// Indicates whether the vehicle been cancelled (either in advance, or en-route)
    var isCancelled:Bool { get }
}