//
//  UTStopBoardGroup.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 03/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

class UTStopBoardGroup : UTObject, StopBoardGroup {
    
    let groupID:String
    let label:String
    let color:UTColor?
    let colorCompliment:UTColor?

    override init(json: [String : AnyObject]) throws {
        self.groupID = try parse(required: json, key: .GroupID, type: UTStopBoardGroup.self)
        self.label = try parse(required: json, key: .Label, type: UTStopBoardGroup.self)
        self.color = try parse(optional: json, key: .Color, type: UTStopBoardGroup.self) { try UTColor.fromJSON(optional: $0) }
        self.colorCompliment = try parse(optional: json, key: .ColorCompliment, type: UTStopBoardGroup.self) { try UTColor.fromJSON(optional: $0) }
        try super.init(json: json)
    }
}