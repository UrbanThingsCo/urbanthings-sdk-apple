//
//  UTTransitAgency.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 29/04/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

import Foundation

class UTTransitAgency : UTObject, TransitAgency {

    let agencyID:String
    let agencyName:String
    let agencyURL:NSURL
    let agencyTimeZone:NSTimeZone
    let agencyLanguage:String?
    let agencyPhone:String?
    let agencyFareURL:NSURL?
    let agencyRegion:String?
    let agencyImportSource:String?

    override init(json:[String:AnyObject]) throws {
        self.agencyID = try parse(required:json, key: JSONKey.AgencyID, type: UTTransitAgency.self)
        self.agencyName = try parse(required:json, key: .AgencyName, type: UTTransitAgency.self)
        self.agencyURL = try parse(required:json, key:. AgencyURL, type: UTTransitAgency.self) { try NSURL.fromJSON(required:$0) }
        self.agencyTimeZone = try parse(required:json, key: .AgencyTimeZone, type: UTTransitAgency.self) { try NSTimeZone(required: $0) }
        self.agencyLanguage = try parse(optional: json, key: .AgencyLanguage, type: UTTransitAgency.self)
        self.agencyPhone = try parse(optional: json, key: .AgencyPhone, type: UTTransitAgency.self)
        self.agencyFareURL = try parse(optional:json, key:. AgencyFareURL, type: UTTransitAgency.self) { try NSURL.fromJSON(optional:$0) }
        self.agencyRegion = try parse(optional: json, key: JSONKey.AgencyRegion, type: UTTransitAgency.self)
        self.agencyImportSource = try parse(optional: json, key: .AgencyImportSource, type: UTTransitAgency.self)
        try super.init(json:json)
    }
}

