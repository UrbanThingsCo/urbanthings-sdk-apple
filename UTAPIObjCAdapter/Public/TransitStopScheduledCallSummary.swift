//
//  TransitStopScheduledCallSummary.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 15/05/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

import Foundation
import CoreLocation

/// `TransitStopScheduledCallSummary` provides summary details of a single call at a given transit stop.
@objc public protocol TransitStopScheduledCallSummary {
    /// The primaryCode of the TransitStop at which the vehicle calls.
    var transitStopPrimaryCode:String { get }
    /// The name of the TransitStop at which the vehicle calls.
    var transitStopName:String? { get }
    /// The locality Name of the TransitStop at which the vehicle calls.
    var transitStopLocalityName:String? { get }
    /// The time(s) at which the vehicle is scheduled to call and the type of call.
    var scheduledCall:TransitScheduledCall { get }
    /// The geo location of this TransitStop, if available. If not available will be CLLocationCoordinate2DInvalid.
    var transitStopLocation:CLLocationCoordinate2D { get }
}