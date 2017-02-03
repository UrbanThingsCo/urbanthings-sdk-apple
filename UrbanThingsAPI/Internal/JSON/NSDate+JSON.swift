//
//  NSDate+JSON.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 29/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

private var dateParser: DateFormatter = {
    let parser = DateFormatter()
    parser.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    parser.timeZone = TimeZone.current
    return parser
}()

private var timeZoneDateParser: DateFormatter = {
    let parser = DateFormatter()
    parser.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    return parser
}()

private var timeZero: Date = {
    var components = DateComponents()
    components.calendar = Calendar(identifier: Calendar.Identifier.gregorian)
    components.day = 1
    components.month = 1
    components.year = 1
    components.hour = 0
    components.minute = 0
    components.second = 0
    components.timeZone = TimeZone(secondsFromGMT: 0)
    return components.date!
}()

private func removeMicroseconds(s: String) -> String {
    if s.characters.count > 25 {
        let tz = s.substring(from: s.index(s.endIndex, offsetBy: -6))
        let main = s.substring(to: s.index(s.startIndex, offsetBy: -19))
        return main+tz
    }
    return s
}

private func parseDate(string: String) -> Date? {
    let normalised = removeMicroseconds(s: string)
    if let date = timeZoneDateParser.date(from: normalised) {
        return date
    }
    return dateParser.date(from: normalised)
}

extension Date {
    public static func toDate(json: Any?) throws -> Date {
        guard let interval = json as? Double else {
            throw UTAPIError(expected:Double.self, not:json, file:#file, function:#function, line:#line)
        }
        return NSDate(timeIntervalSinceReferenceDate: interval / 10000000.0 + timeZero.timeIntervalSinceReferenceDate) as Date
    }
}

extension String {

    public func optionalDate() -> Date? {
        return parseDate(string: self)
    }

    public func requiredDate() throws -> Date {
        guard let date = parseDate(string: self) else {
            throw UTAPIError(jsonParseError:"Unable to parse string `\(self)` to NSDate", file:#file, function:#function, line:#line)
        }
        return date
    }
}
