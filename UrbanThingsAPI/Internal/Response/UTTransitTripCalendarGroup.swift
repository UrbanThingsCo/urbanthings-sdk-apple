//
//  UITransitTripCalendarGroup.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 30/04/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

import Foundation

class UTTransitTripCalendarGroup : UTObject, TransitTripCalendarGroup {
    
    let calendar:TransitCalendar
    let trips:[TransitTrip]
    
    override init(json:[String:AnyObject]) throws {
        self.calendar = try parse(required:json, key: .Calendar, type: UTTransitCalendar.self) as UTTransitCalendar
        self.trips = try parse(required:json, key: .Trips, type:UTTransitCalendar.self) { try [UTTransitTrip](required:$0) }.map { $0 as TransitTrip }
        try super.init(json:json)
    }
}