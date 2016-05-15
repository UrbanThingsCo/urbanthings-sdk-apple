//
//  UTDisruption.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 03/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

class UTDisruption : UTObject, Disruption {
    
    let startDate:NSDate?
    let endDate:NSDate?
    let localizedSummary:String?
    let localizedDescription:String?
    let localizedAdditionalInfo:String?
    let severity:DisruptionSeverity

    override init(json: [String : AnyObject]) throws {
        self.startDate = try parse(optional:json, key: .StartDate, type:UTDisruption.self) { try String(optional: $0)?.requiredDate() }
        self.endDate = try parse(optional:json, key: .EndDate, type:UTDisruption.self) { try String(optional: $0)?.requiredDate() }
        self.localizedSummary = try parse(optional: json, key: .LocalizedSummary, type:UTDisruption.self)
        self.localizedDescription = try parse(optional: json, key: .LocalizedDescription, type:UTDisruption.self)
        self.localizedAdditionalInfo = try parse(optional: json, key: .LocalizedAdditionalInfo, type:UTDisruption.self)
        self.severity = try parse(required: json, key: .Severity, type:UTDisruption.self)
        try super.init(json: json)
    }
}