//
//  TransitTripCalendarGroup.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 29/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

/// Defines a group of trips along a specific route, i.e. a timetable. The trips are grouped according 
/// to the days of the week on which they run. Note that the trips have their individual 'calendar'
/// fields set to nil in order to avoid mass duplication of the data. To ascertain the particular calendar 
/// for each trip, simply examine the `Calendar` field of its parent `TransitTripCalendarGroup` object.
public protocol TransitTripCalendarGroup {
    /// The calendar for all Trips in this grouping, i.e. which days/dates do these trips run on.
    var calendar:TransitCalendar { get }
    /// A list of the TransitTrip objects that form this particular group
    var trips:[TransitTrip] { get }
}