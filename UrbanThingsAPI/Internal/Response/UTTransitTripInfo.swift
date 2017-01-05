//
//  UTTransitTripInfo.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 29/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

class UTTransitTripInfo : UTObject, TransitTripInfo {
    
    let agencyCode:String?
    let tripID:String?
    let originName:String?
    let originPrimaryCode:String?
    let headsign:String?
    let directionName:String?
    let directionID:UInt?
    let vehicleID:String?
    let isWheelchairAccessible:Bool?

    override init(json:[String:Any]) throws {
        self.agencyCode = try parse(optional:json, key: .AgencyCode, type: UTTransitTripInfo.self)
        self.tripID = try parse(optional:json, key: .TripID, type: UTTransitTripInfo.self)
        self.originName = try parse(optional:json, key: .OriginName, type: UTTransitTripInfo.self)
        self.originPrimaryCode = try parse(optional:json, key: .OriginPrimaryCode, type: UTTransitTripInfo.self)
        self.headsign = try parse(optional:json, key: .Headsign, type: UTTransitTripInfo.self)
        self.directionName = try parse(optional:json, key: .DirectionName, type: UTTransitTripInfo.self)
        self.vehicleID = try parse(optional:json, key: .VehicleID, type: UTTransitTripInfo.self)
        self.directionID = try parse(optional: json, key: .DirectionID, type: UTTransitTripInfo.self)
        self.isWheelchairAccessible = try parse(optional: json, key: .IsWheelcharAccessible, type: UTTransitTripInfo.self)
        try super.init(json:json)
    }
}
