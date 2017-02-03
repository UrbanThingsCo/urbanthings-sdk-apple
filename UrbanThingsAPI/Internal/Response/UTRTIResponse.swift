//
//  UTRTIResponse.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 03/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

class UTRTIResponse : UTObject, RTIResponse {
    
    let stopID:String
    let noDataLabel:String?
    let sourceName:String
    
    override init(json: [String : Any]) throws {
        self.stopID = try parse(required:json, key:.StopID, type: UTRTIResponse.self)
        self.noDataLabel = try parse(optional:json, key:.NoDataLabel, type: UTRTIResponse.self)
        self.sourceName = try parse(required:json, key:.SourceName, type: UTRTIResponse.self)
        try super.init(json:json)
    }
}
