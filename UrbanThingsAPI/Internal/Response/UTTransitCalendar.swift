//
//  UITransitCalendar.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 29/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

class UTTransitCalendar : UTObject, TransitCalendar {
    
    let calendarID:String
    let startDate:NSDate
    let endDate:NSDate
    let runsOn:Set<WeekDay>
    let additionalRunningDates:[NSDate]
    let excludedRunningDates:[NSDate]

    override init(json:[String:AnyObject]) throws {
        self.calendarID = try parse(required:json, key:.ID, type:UTTransitCalendar.self)
        self.startDate = try parse(required:json, key: .StartDate, type:UTTransitCalendar.self) { try String(required: $0).requiredDate() }
        self.endDate = try parse(required:json, key: .EndDate, type:UTTransitCalendar.self) { try String(required: $0).requiredDate() }
        self.runsOn = try Set<WeekDay>(WeekDay.week.filter { try parse(optional: json, key:$0.jsonKey, type: UTTransitCalendar.self) ?? false })
        self.additionalRunningDates = try parse(required:json, key: .AdditionalRunningDates, type: UTTransitCalendar.self) { try UTTransitCalendar.dateArray($0) }
        self.excludedRunningDates = try parse(required:json, key: .ExcludedRunningDates, type: UTTransitCalendar.self) { try UTTransitCalendar.dateArray($0) }
        try super.init(json:json)
    }
    
    func runsOn(weekday:WeekDay) -> Bool {
        return self.runsOn.contains(weekday)
    }

    static func dateArray(json:AnyObject?) throws -> [NSDate] {
        guard let array = json as? [String] else {
            return []
        }
        
        return try array.map { try $0.requiredDate() }
    }
}

extension WeekDay {
    static let week:[WeekDay] = [.Sunday, .Monday, .Tuesday, .Wednesday, .Thursday, .Friday, .Saturday]
    var jsonKey:JSONKey {
        switch self {
        case .Sunday:
            return .RunsSunday
        case .Monday:
            return .RunsMonday
        case .Tuesday:
            return .RunsTuesday
        case .Wednesday:
            return .RunsWednesday
        case .Thursday:
            return .RunsThursday
        case .Friday:
            return .RunsFriday
        case .Saturday:
            return .RunsSaturday
        }
    }
}