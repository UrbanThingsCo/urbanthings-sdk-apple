//
//  TransitStop.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 26/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

let TransitStopClassType = "TransitStop"

class UTTransitStop : UTPlacePoint, TransitStop {
    
    let additionalCode:String?
    let smsCode:String?
    let bearing:Int?
    let directionName:String?
    let stopIndicator:String?
    let isClosed:Bool
    let stopMode:TransitMode

    override init(json:[String:AnyObject]) throws {
        self.additionalCode = try parse(optional:json, key: .AdditionalCode, type: UTTransitStop.self)
        self.smsCode = try parse(optional:json, key: .SmsCode, type: UTTransitStop.self)
        self.bearing = try parse(optional: json, key: .Bearing, type: UTTransitStop.self)
        self.directionName = try parse(optional:json, key: .DirectionName, type: UTTransitStop.self)
        self.stopIndicator = try parse(optional:json, key: .StopIndicator, type: UTTransitStop.self)
        self.isClosed = try parse(required:json, key: .IsClosed, type: UTTransitStop.self)
        self.stopMode = try parse(required:json, key: .StopMode, type: UTTransitStop.self)
        try super.init(json:json)
    }
}
