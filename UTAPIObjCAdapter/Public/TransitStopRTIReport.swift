//
//  TransitStopRTIReport.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 15/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation
import protocol UrbanThingsAPI.TransitStopRTIReport

/// `TransitStopRTIReport` provides a report for a particular stop. There may be multiple reports for a stop.
@objc public protocol TransitStopRTIReport : Attribution {
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

@objc public class UTTransitStopRTIReport : UTAttribution, TransitStopRTIReport {
    
    var transitStopRTIReport:UrbanThingsAPI.TransitStopRTIReport { return self.adapted as! UrbanThingsAPI.TransitStopRTIReport }
    
    public init(adapt: UrbanThingsAPI.TransitStopRTIReport) {
        self.upcomingCalls = adapt.upcomingCalls.map { UTMonitoredStopCall(adapt: $0) }
        self.disruptions = adapt.disruptions.map { UTDisruption(adapt: $0) }
        super.init(adapt: adapt)
    }
    
    public var reportName:String? { return self.transitStopRTIReport.reportName }
    public var platformID:String? { return self.transitStopRTIReport.platformID }
    public let upcomingCalls:[MonitoredStopCall]
    public let disruptions:[Disruption]
    public var noDataLabel:String? { return self.transitStopRTIReport.noDataLabel }
    public var sourceName:String { return self.transitStopRTIReport.sourceName }
    public var timestamp:NSDate? { return self.transitStopRTIReport.timestamp }
}
