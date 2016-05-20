//
//  TransitAgency.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 15/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation
import UTAPI

/// `TransitAgency` provides details for a transit agency.
@objc public protocol TransitAgency : NSObjectProtocol {
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

@objc public class UTTransitAgency : NSObject, TransitAgency {
    
    let adapted: UTAPI.TransitAgency
    
    public init(adapt: UTAPI.TransitAgency) {
        self.adapted = adapt
    }

    public var agencyID:String { return self.adapted.agencyID }
    public var agencyName:String { return self.adapted.agencyName }
    public var agencyURL:NSURL { return self.adapted.agencyURL }
    public var agencyTimeZone:NSTimeZone { return self.adapted.agencyTimeZone }
    public var agencyLanguage:String? { return self.adapted.agencyLanguage }
    public var agencyPhone:String? { return self.adapted.agencyPhone }
    public var agencyFareURL:NSURL? { return self.adapted.agencyFareURL }
    public var agencyRegion:String? { return self.adapted.agencyRegion }
    public var agencyImportSource:String? { return self.adapted.agencyImportSource }
}
