//
//  UTDirectionsResponse.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 03/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

class UTDirectionsResponse : UTObject, DirectionsResponse {
    
    let responseID:String?
    let status:DirectionsResponseStatus
    let journeys:[Journey]?
    let placePoints:[PlacePoint]?
    let sourceName:String?
    let attributionsHTML:String?
    let warningsHTML:String?
    
    override init(json:[String:Any]) throws {
        self.responseID = try parse(optional: json, key:.ResponseID, type: UTDirectionsResponse.self)
        self.status = try parse(required: json, key: .Status, type: UTDirectionsResponse.self) as UTDirectionsResponseStatus
        self.journeys = try parse(required:json, key: .Journeys, type:UTDirectionsResponse.self) { try [UTJourney](required:$0) }.map { $0 as Journey }
        self.placePoints = try parse(required:json, key: .PlacePoints, type:UTDirectionsResponse.self) { try [UTPlacePoint].fromJSON(required: $0).map { $0 as PlacePoint } }
        self.sourceName = try parse(optional: json, key: .SourceName, type: UTDirectionsResponse.self)
        self.attributionsHTML = try parse(optional: json, key: .AttributionsHTML, type: UTDirectionsResponse.self)
        self.warningsHTML = try parse(optional: json, key: .WarningsHTML, type: UTDirectionsResponse.self)
        try super.init(json: json)
    }

}
