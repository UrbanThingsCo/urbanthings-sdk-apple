//
//  TransitCalendar.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 15/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation
import UTAPI

/// `TransitCalendar` provides details about the dates / days of the week that a particular `TransitTrip` operates.
@objc public protocol TransitCalendar {
    /// The internal unique ID representing this calendar. Multiple trips may share a single calendar. This ID is synonymous with a GTFS 'service ID'
    var calendarID:String { get }
    /// The date that the corresponding TransitTrip begins operating from, inclusive.
    var startDate:NSDate { get }
    /// The date that the corresponding TransitTrip ends operating on, inclusive.
    var endDate:NSDate { get }
    /// A list of additional dates that this TransitRoute operates on, in addition to the regular day-based services indicated by the runsOn property. Note that these dates do not have to conform to any particular day of the week, e.g. a service could not have Monday in runsOn, but also contain an Additional Date that happened to fall on a Monday.
    var additionalRunningDates:[NSDate] { get }
    /// A list of dates that this TransitRoute does not operate on, overriding any dates implied by the runsOn property.
    var excludedRunningDates:[NSDate] { get }
    /// Test if the trip runs on a particular day of the week
    func runsOn(weekday:WeekDay) -> Bool
}

@objc public class UTTransitCalendar : NSObject, TransitCalendar {
    
    let adapted: UTAPI.TransitCalendar
    
    public init?(adapt: UTAPI.TransitCalendar?) {
        guard let adapt = adapt else {
            return nil
        }
        self.adapted = adapt
    }
    
    public var calendarID:String { return self.adapted.calendarID }
    public var startDate:NSDate { return self.adapted.startDate }
    public var endDate:NSDate { return self.adapted.endDate }
    public var additionalRunningDates:[NSDate] { return self.adapted.additionalRunningDates }
    public var excludedRunningDates:[NSDate] { return self.adapted.excludedRunningDates }
    public func runsOn(weekday:WeekDay) -> Bool { return self.adapted.runsOn(weekday) }
}
