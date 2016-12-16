//
//  UTStopBoardResponse.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 03/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

class UTStopBoardResponse : UTRTIResponse, StopBoardResponse {
    
    let timestamp:Date?
    let stopBoards:[StopBoard]?

    override init(json: [String : Any]) throws {
        self.timestamp = try parse(optional: json, key: .Timestamp, type: UTStopBoardResponse.self) { try Date.toDate(json: $0) }
        self.stopBoards = try [UTStopBoard](required: json[.StopBoards]).map { $0 as StopBoard }
        try super.init(json: json)
    }
}
