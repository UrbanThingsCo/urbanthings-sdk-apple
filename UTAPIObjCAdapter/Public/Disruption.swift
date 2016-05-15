//
//  Disruption.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 15/05/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

import Foundation
import UrbanThingsAPI

/// Defines properties for a disruption record.
@objc public protocol Disruption {
    /// The date and time at which this disruption started, or will start. If nil, the start date/time of the disruption is assumed to have passed
    var startDate:NSDate? { get }
    /// The date and time at which this disruption will end, or ended. If nil, it is assumed that the end date/time of the disruption has not passed
    var endDate:NSDate? { get }
    /// A textual summary description of the nature of the disruption
    var localizedSummary:String? { get }
    /// A detailed description of the nature of the disruption
    var localizedDescription:String? { get }
    /// Additional information relating to the disruption
    var localizedAdditionalInfo:String? { get }
    /// The severity of the disruption, on a scale of 1-10, with 10 being the most severe
    var severity:DisruptionSeverity { get }
    
}