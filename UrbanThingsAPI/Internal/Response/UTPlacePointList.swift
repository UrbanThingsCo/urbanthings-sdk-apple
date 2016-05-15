//
//  UTPlacePointList.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 27/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

class UTPlacePointList : UTObject, PlacePointList {
    
    let placePoints:[PlacePoint]
    let sourceName:String
    let sourceIconURL:NSURL
    
    override init(json:[String:AnyObject]) throws {
        self.placePoints = try parse(required:json, key: .PlacePoints, type:UTPlacePointList.self) { try [UTPlacePoint](required:$0) }.map { $0 as PlacePoint }
        self.sourceName = try parse(required:json, key: .SourceName, type: UTPlacePointList.self)
        self.sourceIconURL = try parse(required:json, key:. SourceIconURL, type: UTAttribution.self) { try NSURL.fromJSON(required:$0) }
        try super.init(json:json)
    }
}
