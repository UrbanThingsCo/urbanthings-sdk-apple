//
//  AppOperatorsResponse.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 08/08/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

public enum AgencyPresenceKind: String {
    case Telephone = "Telephone"
    case Minicom = "Minicom"
    case SMS = "SMS"
    case Fax = "Fax"
    case Email = "Email"
    case WebPage = "WebPage"
    case PostalAddress = "PostalAddress"
    case Twitter = "Twitter"
    case Facebook = "Facebook"
    case LinkedIn = "LinkedIn"
    case Pinterest = "Pinterest"
    case YouTube = "YouTube"
    case Medium = "Medium"
    case Instagram = "Instagram"
    case Slack = "Slack"
    case GooglePlus = "GooglePlus"
    case Skype = "Skype"
    case Tumblr = "Tumblr"
    case Flickr = "Flickr"
    case Foursquare = "Foursquare"
    case Vimeo = "Vimeo"
    case Reddit = "Reddit"
    case RSS = "RSS"
}

/// Extend `DisruptionSeverity` enum to support JSONInitialization protocol for JSON parsing.
extension AgencyPresenceKind : JSONInitialization {

    /// Initializer to parse JSON object into `DisruptionSeverity`. A result is required and so if
    /// input is nil, or not parsable as `Bool` an error is thrown.
    ///  - parameters:
    ///    - required: Input JSON object that is required to be parsed into a `DisruptionSeverity`.
    ///  - throws: Error.JSONParseError if unable to parse into `DisruptionSeverity`.
    init(required: AnyObject?) throws {
        guard let rawValue = required as? String else {
            throw Error(expected:Int.self, not:required, file:#file, function:#function, line:#line)
        }
        guard let value = AgencyPresenceKind(rawValue:rawValue) else {
            throw Error(enumType: AgencyPresenceKind.self, invalidRawValue: rawValue, file:#file, function:#function, line:#line)
        }
        self = value
    }

    init?(optional: AnyObject?) throws {
        guard optional != nil else {
            return nil
        }
        try self.init(required: optional)
    }
}

public enum AgencyPresenceNature: String {
    case CustomerServices = "CustomerServices"
    case LostProperty = "LostProperty"
    case Disruptions = "Disruptions"
    case FareEquiries = "FareEnquiries"
    case TimeTableEnquiries = "TimeTableEnquiries"
    case RouteEnquiries = "RouteEnquiries"
    case GeneralEnquiries = "GeneralEnquiries"
    case Sales = "Sales"
    case Corporate = "Corporate"
}

/// Extend `DisruptionSeverity` enum to support JSONInitialization protocol for JSON parsing.
extension AgencyPresenceNature : JSONInitialization {

    /// Initializer to parse JSON object into `DisruptionSeverity`. A result is required and so if
    /// input is nil, or not parsable as `Bool` an error is thrown.
    ///  - parameters:
    ///    - required: Input JSON object that is required to be parsed into a `DisruptionSeverity`.
    ///  - throws: Error.JSONParseError if unable to parse into `DisruptionSeverity`.
    init(required: AnyObject?) throws {
        guard let rawValue = required as? String else {
            throw Error(expected:Int.self, not:required, file:#file, function:#function, line:#line)
        }
        guard let value = AgencyPresenceNature(rawValue:rawValue) else {
            throw Error(enumType: AgencyPresenceNature.self, invalidRawValue: rawValue, file:#file, function:#function, line:#line)
        }
        self = value
    }

    init?(optional: AnyObject?) throws {
        guard optional != nil else {
            return nil
        }
        try self.init(required: optional)
    }
}

public protocol AppAgenciesResponse {
    var items: [Agency] { get }
}

class UTAppAgenciesResponse: UTObject, AppAgenciesResponse {

    let items: [Agency]

    override init(json: [String : AnyObject]) throws {
        self.items = try parse(required:json, key: .Items, type:UTAppAgenciesResponse.self) { try [UTAgency](required:$0) }.map { $0 as Agency }
        try super.init(json: json)
    }
}
