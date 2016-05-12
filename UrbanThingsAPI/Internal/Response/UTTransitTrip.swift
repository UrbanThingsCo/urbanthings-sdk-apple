//
//  UTTransitTrip.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 29/04/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

import Foundation

class UTTransitTrip : UTObject, TransitTrip {
    
    let info:TransitTripInfo
    let calendar:TransitCalendar?
    let stopCalls:[TransitStopScheduledCallSummary]
    let polyline:String?

    override init(json:[String:AnyObject]) throws {
        self.info = try parse(required:json, key: .Info, type: UTTransitTrip.self) as UTTransitTripInfo
        self.calendar = try parse(optional:json, key: .Calendar, type: UTTransitTrip.self) as UTTransitCalendar?
        self.stopCalls = try parse(required:json, key: .StopCalls, type:UTTransitTrip.self) { try [UTTransitStopScheduledCallSummary](required:$0) }.map { $0 as TransitStopScheduledCallSummary }
        self.polyline = try parse(optional:json, key: .Polyline, type: UTTransitTrip.self)
        try super.init(json:json)
    }
}