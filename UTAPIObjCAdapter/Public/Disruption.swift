//
//  Disruption.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 15/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation
import UTAPI

/// Defines properties for a disruption record.
@objc public protocol Disruption : NSObjectProtocol {
    /// The date and time at which this disruption started, or will start. If nil, the start date/time of the disruption is assumed to have passed
    var startDate:Date? { get }
    /// The date and time at which this disruption will end, or ended. If nil, it is assumed that the end date/time of the disruption has not passed
    var endDate:Date? { get }
    /// A textual summary description of the nature of the disruption
    var localizedSummary:String? { get }
    /// A detailed description of the nature of the disruption
    var localizedDescription:String? { get }
    /// Additional information relating to the disruption
    var localizedAdditionalInfo:String? { get }
    /// The severity of the disruption, on a scale of 1-10, with 10 being the most severe
    var severity:DisruptionSeverity { get }
    
}

@objc public class UTDisruption : NSObject, Disruption {
    
    let adapted:UTAPI.Disruption
    
    public init(adapt:UTAPI.Disruption) {
        self.adapted = adapt
    }
    
    public var startDate:Date? { return self.adapted.startDate }
    public var endDate:Date? { return self.adapted.endDate }
    public var localizedSummary:String? { return self.adapted.localizedSummary }
    public var localizedDescription:String? { return self.adapted.localizedDescription }
    public var localizedAdditionalInfo:String? { return self.adapted.localizedAdditionalInfo }
    public var severity:DisruptionSeverity { return self.adapted.severity }
}
