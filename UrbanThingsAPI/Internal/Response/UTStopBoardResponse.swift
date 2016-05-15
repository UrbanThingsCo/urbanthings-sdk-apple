//
//  UTStopBoardResponse.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 03/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

class UTStopBoardResponse : UTRTIResponse, StopBoardResponse {
    
    let timestamp:NSDate?
    let stopBoards:[StopBoard]?
    let enableAutoRefresh:Bool

    override init(json: [String : AnyObject]) throws {
        self.timestamp = try parse(optional:json, key: .Timestamp, type:UTStopBoardResponse.self) { try NSDate.toDate($0) }
        self.stopBoards = try [UTStopBoard](required: json[.StopBoards]).map { $0 as StopBoard }
        self.enableAutoRefresh = try parse(required: json, key: .EnableAutoRefresh, type: UTStopBoardResponse.self)
        try super.init(json: json)
    }
}