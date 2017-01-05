//
//  UTResourceStatus.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 03/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

class UTResourceStatus : UTAttribution, ResourceStatus {
    
    let primaryCode:String 
    let importSourceID:String 
    let timestamp:Date 
    let statusText:String? 
    let availablePlaces:Int?
    let takenPlaces:Int?
    let isClosed:Bool 
    let trend:ResourceTrend?
    let customStatusCode:Int?
    let vehicleType:TransitMode
    
    override init(json: [String : Any]) throws {
        self.primaryCode = try parse(required: json, key: .PrimaryCode, type: UTResourceStatus.self)
        self.importSourceID = try parse(required: json, key: .ImportSourceID, type: UTResourceStatus.self)
        self.statusText = try parse(optional: json, key: .StatusText, type: UTResourceStatus.self)
        self.availablePlaces = try parse(optional: json, key: .AvailablePlaces, type: UTResourceStatus.self)
        self.takenPlaces = try parse(optional: json, key: .TakenPlaces, type: UTResourceStatus.self)
        self.isClosed = try parse(required: json, key: .IsClosed, type: UTResourceStatus.self)
        self.customStatusCode = try parse(optional: json, key: .CustomStatusCode, type: UTResourceStatus.self)
        self.trend = try parse(optional: json, key: .Trend, type: UTResourceStatus.self)
        self.timestamp = try parse(required:json, key: .Timestamp, type:UTResourceStatus.self) { try String(required: $0).requiredDate() }
        self.vehicleType = try parse(required: json, key: .VehicleType, type: UTResourceStatus.self)
        try super.init(json: json)
    }

}
