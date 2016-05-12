//
//  UTStopCall.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 30/04/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

import Foundation

class UTStopCall : UTObject, StopCall {
    
    let tripInfo:TransitTripInfo
    let routeInfo:TransitRouteInfo
    let scheduledCall:TransitScheduledCall
    
    override init(json: [String : AnyObject]) throws {
        self.tripInfo = try parse(required: json, key: .TripInfo, type: UTStopCall.self) as UTTransitTripInfo
        self.routeInfo = try parse(required: json, key: .RouteInfo, type: UTStopCall.self) as UTTransitRouteInfo
        self.scheduledCall = try parse(required:json, key: .ScheduledCall, type: UTStopCall.self) as UTTransitScheduledCall
        try super.init(json:json)
    }
}
