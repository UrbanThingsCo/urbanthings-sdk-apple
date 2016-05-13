//
//  TransitStopRTIReport.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 26/04/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

import Foundation

/// `TransitStopRTIReport` provides a report for a particular stop. There may be multiple reports for a stop.
public protocol TransitStopRTIReport : Attribution {
    /// An optional descriptive title for this report - may be used to distinguish between multiple `TransitStopRTIReport`
    /// instances in a `TransitStopRTIResponse`.
    var reportName:String? { get }
    /// The platform that this report relates to, if applicable. Note that the stop ID that this report relates to is held
    // in the parent `TransitStopRTIResponse` instance.
    var platformID:String? { get }
    /// Upcoming vehicle calls at this stop, and metadata relating to each vehicle.
    var upcomingCalls:[MonitoredStopCall] { get }
    /// A list of disruptions information relating to this stop.
    var disruptions:[Disruption] { get }
    /// A string that indicates the reason why no data has been returned in this report. In cases where `UpcomingCall` 
    /// instances exist, this will be nil.
    var noDataLabel:String? { get }
    /// A descriptive, customer-facing name for the source of this information.
    var sourceName:String { get }
    /// The time at which this report was generated. Can be used to generate a more accurate 'waiting time until vehicle comes' 
    /// since we know what the server THOUGHT the time was when it generated the expected time.
    var timestamp:NSDate? { get }
}