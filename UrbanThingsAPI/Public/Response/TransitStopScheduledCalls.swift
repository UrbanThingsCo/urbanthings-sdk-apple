//
//  TransitStopScheduledCalls.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 29/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

/// `TransitStopScheduledCalls` provides details of scheduled calls for a particular transit stop.
public protocol TransitStopScheduledCalls {
    /// The primary code of the TransitStop that this list relates to
    var stopID:String { get }
    /// The beginning of the time period to which this list of stop calls relates.
    var startTime:NSDate? { get }
    /// The end of the time period to which this list of stop calls relates.
    var endTime:NSDate? { get }
    /// A list of vehicles calling at this TransitStop within the specified time period.
    var scheduledCalls:[StopCall] { get }
}

