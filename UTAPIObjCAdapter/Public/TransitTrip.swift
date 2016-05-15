//
//  TransitTrip.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 15/05/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

import Foundation

/// `TransitTrip` details a transit route and one of the scheduled times that the route runs.
@objc public protocol TransitTrip {
    /// Basic information about this trip - agency code, vehicle Headsign, etc.
    var info:TransitTripInfo { get }
    /// The dates on which this trip operates.
    var calendar:TransitCalendar? { get }
    /// The stops that the vehicle calls at on this trip, and the times at which it does so.
    var stopCalls:[TransitStopScheduledCallSummary] { get }
    /// Google polyline string representing the route
    var polyline:String? { get }
}