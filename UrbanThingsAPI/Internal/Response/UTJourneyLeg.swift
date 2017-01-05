//
//  UTJourneyLeg.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 03/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

class UTJourneyLeg : UTJourneyCore, JourneyLeg {
    
    let vehicleType:TransitMode
    let distance:UInt?
    let polyline:String? 

    override init(json: [String : Any]) throws {
        self.vehicleType = try parse(required: json, key: .VehicleType, type: UTJourneyLeg.self)
        self.distance = try parse(optional: json, key: .Distance, type: UTJourneyLeg.self)
        self.polyline = try parse(optional: json, key: .Polyline, type: UTJourneyLeg.self)
        try super.init(json: json)
    }
}
