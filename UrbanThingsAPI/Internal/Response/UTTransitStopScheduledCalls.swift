//
//  UTTransitStopScheduledCalls.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 30/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

class UTTransitStopScheduledCalls : UTObject, TransitStopScheduledCalls {
    
    let stopID:String
    let startTime:Date?
    let endTime:Date?
    let scheduledCalls:[StopCall]

    override init(json:[String:Any]) throws {
        self.stopID = try parse(required:json, key: .StopID, type: UTTransitStopScheduledCalls.self)
        self.startTime = try parse(optional:json, key: .QueryStartTime, type:UTTransitStopScheduledCalls.self) { try String(optional: $0)?.requiredDate() }
        self.endTime = try parse(optional:json, key: .QueryEndTime, type:UTTransitStopScheduledCalls.self) { try String(optional: $0)?.requiredDate() }
        self.scheduledCalls = try parse(required:json, key: .ScheduledCalls, type:UTTransitStopScheduledCalls.self) { try [UTStopCall](required:$0) }.map { $0 as StopCall }
        try super.init(json:json)
    }
}
