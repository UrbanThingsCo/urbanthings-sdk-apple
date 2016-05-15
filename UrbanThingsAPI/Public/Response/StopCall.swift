//
//  StopCall.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 29/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

/// `StopCall` details a particular vehicle's timetabled stop at a particular transit stop.
public protocol StopCall {
    /// This provides information about the destination (headsign), origin, vehicle registration, etc.
    var tripInfo:TransitTripInfo { get }
    /// This provides information about the line name, vehicle mode, operator name, etc.
    var routeInfo:TransitRouteInfo { get }
    /// This provides information about the scheduled arrival/departure time.
    var scheduledCall:TransitScheduledCall { get }
}
