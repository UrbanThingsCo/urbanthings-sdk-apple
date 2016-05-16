//
//  StopCall.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 15/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation
import protocol UrbanThingsAPI.StopCall

/// `StopCall` details a particular vehicle's timetabled stop at a particular transit stop.
@objc public protocol StopCall {
    /// This provides information about the destination (headsign), origin, vehicle registration, etc.
    var tripInfo:TransitTripInfo { get }
    /// This provides information about the line name, vehicle mode, operator name, etc.
    var routeInfo:TransitRouteInfo { get }
    /// This provides information about the scheduled arrival/departure time.
    var scheduledCall:TransitScheduledCall { get }
}

@objc public class UTStopCall : NSObject, StopCall {
    
    let adapted:UrbanThingsAPI.StopCall
    
    public init(adapt:UrbanThingsAPI.StopCall) {
        self.adapted = adapt
        self.tripInfo = UTTransitTripInfo(adapt: adapt.tripInfo)!
        self.routeInfo = UTTransitRouteInfo(adapt: adapt.routeInfo)!
        self.scheduledCall = UTTransitScheduledCall(adapt: adapt.scheduledCall)
    }
    
    public let tripInfo:TransitTripInfo
    public let routeInfo:TransitRouteInfo
    public let scheduledCall:TransitScheduledCall
}
