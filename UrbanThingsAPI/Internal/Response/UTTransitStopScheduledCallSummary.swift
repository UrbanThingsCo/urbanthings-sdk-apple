//
//  UTTransitStopScheduledCallSummary.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 29/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation
import CoreLocation

class UTTransitStopScheduledCallSummary : UTObject, TransitStopScheduledCallSummary {
    
    let transitStopPrimaryCode:String
    let transitStopName:String?
    let transitStopLocalityName:String?
    let scheduledCall:TransitScheduledCall
    let transitStopLocation:Location?
    
    override init(json:[String:Any]) throws {
        self.transitStopPrimaryCode = try parse(required:json, key: .TransitStopPrimaryCode, type: UTTransitStopScheduledCallSummary.self)
        self.transitStopName = try parse(optional:json, key: .TransitStopName, type: UTTransitStopScheduledCallSummary.self)
        self.transitStopLocalityName = try parse(optional:json, key: .TransitStopLocalityName, type: UTTransitStopScheduledCallSummary.self)
        self.transitStopLocation = try parse(optional: json, type: UTTransitRouteInfo.self, property: "transitStopLocation") { try UTLocation(optional:$0, latitude: .TransitStopLatitude, longitude: .TransitStopLongitude) }
        self.scheduledCall = try parse(required:json, key: .ScheduledCall, type: UTTransitStopScheduledCallSummary.self) as UTTransitScheduledCall
        try super.init(json:json)
    }
}
