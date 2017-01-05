//
//  UTDirectionsResponseStatus.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 03/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

class UTDirectionsResponseStatus : UTObject, DirectionsResponseStatus {
    
    let statusCode:Int
    let errorCode:Int
    let errorMessage:String?

    override init(json: [String : Any]) throws {
        self.statusCode = try parse(required: json, key: .StatusCode, type: UTDirectionsResponseStatus.self)
        self.errorCode = try parse(required: json, key: .ErrorCode, type: UTDirectionsResponseStatus.self)
        self.errorMessage = try parse(optional: json, key: .ErrorMessage, type: UTDirectionsResponseStatus.self)
        try super.init(json: json)
    }
}
