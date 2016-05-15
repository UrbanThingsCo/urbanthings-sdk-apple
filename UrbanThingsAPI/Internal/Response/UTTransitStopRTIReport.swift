//
//  UTTransitStopRTIReport.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 02/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

class UTTransitStopRTIReport : UTAttribution, TransitStopRTIReport {
    
    let reportName:String?
    let platformID:String?
    let upcomingCalls:[MonitoredStopCall]
    let disruptions:[Disruption]
    let noDataLabel:String?
    let sourceName:String
    let timestamp:NSDate?

    override init(json: [String : AnyObject]) throws {
        self.reportName = try parse(optional: json, key: .ReportName, type: UTTransitStopRTIReport.self)
        self.platformID = try parse(optional: json, key: .PlatformID, type: UTTransitStopRTIReport.self)
        self.upcomingCalls = try parse(required:json, key: .UpcomingCalls, type:UTTransitStopRTIReport.self) { try [UTMonitoredStopCall](required:$0) }.map { $0 as MonitoredStopCall }
        self.disruptions = try parse(required:json, key: .Disruptions, type:UTTransitStopRTIReport.self) { try [UTDisruption](required:$0) }.map { $0 as Disruption }
        self.noDataLabel = try parse(optional: json, key: .NoDataLabel, type: UTTransitStopRTIReport.self)
        self.sourceName = try parse(required: json, key: .SourceName, type: UTTransitStopRTIReport.self)
        self.timestamp = try parse(optional:json, key: .Timestamp, type:UTDisruption.self) { try String(optional: $0)?.requiredDate() }
        try super.init(json: json)
    }
}