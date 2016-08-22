//
//  NSDate+JSON.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 29/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

private var token: dispatch_once_t = 0
private var _dateParser: NSDateFormatter?
private var _timeZoneDateParser: NSDateFormatter?
private var _timeZero: NSDate?

private func setupParsers() {
    dispatch_once(&token) {
        _dateParser = NSDateFormatter()
        _dateParser!.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        _dateParser!.timeZone = NSTimeZone.localTimeZone()
        _timeZoneDateParser = NSDateFormatter()
        _timeZoneDateParser!.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        let components = NSDateComponents()
        components.calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        components.day = 1
        components.month = 1
        components.year = 1
        components.hour = 0
        components.minute = 0
        components.second = 0
        components.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        _timeZero = components.date
    }
}

private var dateParser: NSDateFormatter {
    setupParsers()
    return _dateParser!
}

private var timeZoneDateParser: NSDateFormatter {
    setupParsers()
    return _timeZoneDateParser!
}

private func removeMicroseconds(s: String) -> String {
    if s.characters.count > 25 {
        let tz = s.substringFromIndex(s.endIndex.advancedBy(-6))
        let main = s.substringToIndex(s.startIndex.advancedBy(19))
        return main+tz
    }
    return s
}

private func parseDate(string: String) -> NSDate? {
    let normalised = removeMicroseconds(string)
    if let date = timeZoneDateParser.dateFromString(normalised) {
        return date
    }
    return dateParser.dateFromString(normalised)
}

extension NSDate {
    public class func toDate(json: AnyObject?) throws -> NSDate {
        setupParsers()
        guard let interval = json as? Double else {
            throw Error(expected:Double.self, not:json, file:#file, function:#function, line:#line)
        }
        return NSDate(timeIntervalSinceReferenceDate: interval / 10000000.0 + _timeZero!.timeIntervalSinceReferenceDate)
    }
}

extension String {

    public func optionalDate() -> NSDate? {
        return parseDate(self)
    }

    public func requiredDate() throws -> NSDate {
        guard let date = parseDate(self) else {
            throw Error(jsonParseError:"Unable to parse string `\(self)` to NSDate", file:#file, function:#function, line:#line)
        }
        return date
    }
}
