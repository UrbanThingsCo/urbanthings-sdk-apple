//
//  TransitStopScheduledCalls.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 15/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation
import UTAPI

/// `TransitStopScheduledCalls` provides details of scheduled calls for a particular transit stop.
@objc public protocol TransitStopScheduledCalls {
    /// The primary code of the TransitStop that this list relates to
    var stopID:String { get }
    /// The beginning of the time period to which this list of stop calls relates.
    var startTime:NSDate? { get }
    /// The end of the time period to which this list of stop calls relates.
    var endTime:NSDate? { get }
    /// A list of vehicles calling at this TransitStop within the specified time period.
    var scheduledCalls:[StopCall] { get }
}

@objc public class UTTransitStopScheduledCalls : NSObject, TransitStopScheduledCalls {
    
    let adapted: UTAPI.TransitStopScheduledCalls
    
    public init(adapt: UTAPI.TransitStopScheduledCalls) {
        self.adapted = adapt
        self.scheduledCalls = adapt.scheduledCalls.map { UTStopCall(adapt: $0) }
    }
    
    public var stopID:String { return self.adapted.stopID }
    public var startTime:NSDate? { return self.adapted.startTime }
    public var endTime:NSDate? { return self.adapted.endTime }
    public let scheduledCalls:[StopCall]
}
