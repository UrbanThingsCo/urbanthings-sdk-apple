//
//  Disruption.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 26/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

/// Possible levels of disruption.
public enum DisruptionSeverity: Int {
    /// Disruption level 1.
    case Level1 = 1
    /// Disruption level 2.
    case Level2 = 2
    /// Disruption level 3.
    case Level3 = 3
    /// Disruption level 4.
    case Level4 = 4
    /// Disruption level 5.
    case Level5 = 5
    /// Disruption level 6.
    case Level6 = 6
    /// Disruption level 7.
    case Level7 = 7
    /// Disruption level 8.
    case Level8 = 8
    /// Disruption level 9.
    case Level9 = 9
    /// Disruption level 10.
    case Level10 = 10
}

/// Defines properties for a disruption record.
public protocol Disruption {
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