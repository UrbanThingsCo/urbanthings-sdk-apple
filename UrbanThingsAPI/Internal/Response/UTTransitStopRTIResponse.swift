//
//  UTTransitStopRTIResponse.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 02/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

class UTTransitStopRTIResponse : UTRTIResponse, TransitStopRTIResponse {
    
    let rtiReports:[TransitStopRTIReport]?

    override init(json: [String : AnyObject]) throws {
        self.rtiReports = try parse(required:json, key: .RTIReports, type:UTTransitStopRTIReport.self) { try [UTTransitStopRTIReport](required:$0) }.map { $0 as TransitStopRTIReport }
        try super.init(json:json)
    }
}