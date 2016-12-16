//
//  UTPlacePoint.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 26/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation
import CoreLocation

let PlacePointClassType = "PlacePoint"

class UTPlacePoint : UTObject, PlacePoint {
    
    let name:String?
    let primaryCode:String
    let importSource:String?
    let localityName:String?
    let country:String?
    let hasResourceStatus:Bool
    let location:Location
    let placePointType: PlacePointType
    
    override init(json:[String:Any]) throws {
        self.name = try parse(optional:json, key:.Name, type:UTPlacePoint.self)
        self.primaryCode = try parse(required:json, key:.PrimaryCode, type:UTPlacePoint.self)
        self.importSource = try parse(optional:json, key:.ImportSource, type:UTPlacePoint.self)
        self.localityName = try parse(optional:json, key:.LocalityName, type:UTPlacePoint.self)
        self.country = try parse(optional:json, key:.Country, type:UTPlacePoint.self)
        self.hasResourceStatus = try parse(required:json, key:.HasResourceStatus, type:UTPlacePoint.self)
        self.location = try parse(required:json, type:UTPlacePoint.self, property:"location") as UTLocation
        self.placePointType = try parse(required:json, key:.PlacePointType, type:UTPlacePoint.self)
        try super.init(json:json)
    }
    
}
