//
//  UTAttribution.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 02/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

class UTAttribution : UTObject, Attribution {
    
    let attributionLabel: String?
    let attributionImageURL: NSURL?
    let attributionNotes: String?
    
    override class var className:String {
        return "\(self)"
    }
    
    override init(json: [String : AnyObject]) throws {
        self.attributionLabel = try parse(optional: json, key:.AttributionLabel, type: UTAttribution.self)
        self.attributionNotes = try parse(optional: json, key:.AttributionNotes, type: UTAttribution.self)
        self.attributionImageURL = try parse(optional:json, key:. AttributionImageURL, type: UTAttribution.self) { try NSURL.fromJSON(optional:$0) }
        try super.init(json: json)
    }
}