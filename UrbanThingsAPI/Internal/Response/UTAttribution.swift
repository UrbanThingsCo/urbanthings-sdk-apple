//
//  UTAttribution.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 02/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

public class UTAttribution : UTObject, Attribution {
    
    public let attributionLabel: String?
    public let attributionImageURL: NSURL?
    public let attributionNotes: String?
    
    override class var className:String {
        return "\(self)"
    }
    
    public override init(json: [String : AnyObject]) throws {
        self.attributionLabel = try parse(optional: json, key:.AttributionLabel, type: UTAttribution.self)
        self.attributionNotes = try parse(optional: json, key:.AttributionNotes, type: UTAttribution.self)
        self.attributionImageURL = try parse(optional:json, key:. AttributionImageURL, type: UTAttribution.self) { try NSURL.fromJSON(optional:$0) }
        try super.init(json: json)
    }
}