//
//  TransitAgency.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 15/05/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

import Foundation

/// `TransitAgency` provides details for a transit agency.
@objc public protocol TransitAgency {
    /// The unique identifier representing the agency this record relates to.
    var agencyID:String { get }
    /// The name of the transit agency.
    var agencyName:String { get }
    /// The main website for the agency.
    var agencyURL:NSURL { get }
    /// The time zone in which the agency's head office is based.
    var agencyTimeZone:NSTimeZone { get }
    /// An ISO language code representing the agency's main operating language.
    var agencyLanguage:String? { get }
    /// An International phone number for the agency's transit-related customer service department.
    var agencyPhone:String? { get }
    /// The URL of a page detailing the agency's fares, if available.
    var agencyFareURL:NSURL? { get }
    /// The location of the agency.
    var agencyRegion:String? { get }
    /// The data import source for this agency.
    var agencyImportSource:String? { get }
}