//
//  UTTransitScheduledCall.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 29/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

class UTTransitScheduledCall : UTObject, TransitScheduledCall {

    let scheduledArrivalTime:NSDate?
    let scheduledDepartureTime:NSDate?
    let pickupType:TransitCallType?
    let dropoffType:TransitCallType?

    override init(json:[String:AnyObject]) throws {
        self.scheduledArrivalTime = try String(optional: json[.ScheduledArrivalTime])?.requiredDate()
        self.scheduledDepartureTime = try String(optional: json[.ScheduledDepartureTime])?.requiredDate()
        self.pickupType = try parse(optional:json, key: .PickUpType, type: UTTransitScheduledCall.self)
        self.dropoffType = try parse(optional:json, key: .DropOffType, type: UTTransitScheduledCall.self)
        try super.init(json:json)
    }
}
