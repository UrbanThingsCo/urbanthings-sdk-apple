//
//  UTJourneyCore.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 03/05/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

import Foundation

class UTJourneyCore : UTObject {
    
    let arrivalTime:NSDate
    let departureTime:NSDate
    let summaryHTML:String?
    let duration:UInt?
    let originPlacePointID:String
    let destinationPlacePointID:String
    
    override init(json: [String : AnyObject]) throws {
        self.arrivalTime = try parse(required:json, key: .ArrivalTime, type:UTJourneyCore.self) { try String(required: $0).requiredDate() }
        self.departureTime = try parse(required:json, key: .DepartureTime, type:UTJourneyCore.self) { try String(required: $0).requiredDate() }
        self.summaryHTML = try parse(optional: json, key: .SummaryHTML, type:UTJourneyCore.self)
        self.originPlacePointID = try parse(required: json, key: .OriginPlacePointID, type:UTJourneyCore.self)
        self.destinationPlacePointID = try parse(required: json, key: .DestinationPlacePointID, type:UTJourneyCore.self)
        self.duration = try parse(optional: json, key: .Duration, type:UTJourneyCore.self)
        try super.init(json: json)
    }
}

