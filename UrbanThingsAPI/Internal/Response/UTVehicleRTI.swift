//
//  UTVehicleRTI.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 02/05/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

import Foundation

class UTVehicleRTI : UTObject, VehicleRTI {
    
    let agencyCode:String
    let vehicleID:String
    let delayOffsetMinutes:Int?
    let vehicleRegistrationCode:String?
    let vehicleCapacityTotalPassengers:UInt?
    let vehicleOccupancyPassengers:UInt?
    
    override init(json: [String : AnyObject]) throws {
        self.agencyCode = try parse(required: json, key: .AgencyCode, type: UTVehicleRTI.self)
        self.vehicleID = try parse(required: json, key: .VehicleID, type: UTVehicleRTI.self)
        self.vehicleRegistrationCode = try parse(optional:json, key: .VehicleRegistrationCode, type: UTVehicleRTI.self)
        self.delayOffsetMinutes = try parse(optional: json, key: .DelayOffsetMinutes, type: UTVehicleRTI.self)
        self.vehicleCapacityTotalPassengers = try parse(optional: json, key: .VehicleCapacityTotalPassengers, type: UTVehicleRTI.self)
        self.vehicleOccupancyPassengers = try parse(optional: json, key: .VehicleOccupancyPassengers, type: UTVehicleRTI.self)
        try super.init(json: json)
    }
}
