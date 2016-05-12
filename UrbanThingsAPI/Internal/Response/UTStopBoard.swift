//
//  UTStopBoard.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 03/05/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

class UTStopBoard : UTAttribution, StopBoard {
    
    let headerLabel:String? 
    let rows:[StopBoardRow] 
    let groups:[StopBoardGroup] 
    let messages:[StopBoardMessage] 
    let hideSecondary:Bool 
    let hidePlatform:Bool 
    let enableGroupFiltering:Bool 
    let idHeader:String? 
    let mainHeader:String? 
    let secondaryHeader:String? 
    let platformHeader:String? 
    let timeHeader:String? 
    let noDataLabel:String?
    let color:UTColor?
    let colorCompliment:UTColor?

    override init(json: [String : AnyObject]) throws {
        self.headerLabel = try parse(optional: json, key: .HeaderLabel, type: UTStopBoard.self)
        self.rows = try parse(required:json, key: .Rows, type:UTStopBoard.self) { try [UTStopBoardRow](required:$0) }.map { $0 as StopBoardRow }
        self.groups = try parse(required:json, key: .Groups, type:UTStopBoardGroup.self) { try [UTStopBoardGroup](required:$0) }.map { $0 as StopBoardGroup }
        self.messages = try parse(required:json, key: .Messages, type:UTStopBoardGroup.self) { try [UTStopBoardMessage](required:$0) }.map { $0 as StopBoardMessage }
        self.hideSecondary = try parse(required: json, key: .HideSecondary, type: UTStopBoard.self)
        self.hidePlatform = try parse(required: json, key: .HidePlatform, type: UTStopBoard.self)
        self.enableGroupFiltering = try parse(required: json, key: .EnableGroupFiltering, type: UTStopBoard.self)
        self.idHeader = try parse(optional: json, key: .IDHeader, type: UTStopBoard.self)
        self.mainHeader = try parse(optional: json, key: .MainHeader, type: UTStopBoard.self)
        self.secondaryHeader = try parse(optional: json, key: .SecondaryHeader, type: UTStopBoard.self)
        self.platformHeader = try parse(optional: json, key: .PlatformHeader, type: UTStopBoard.self)
        self.timeHeader = try parse(optional: json, key: .TimeHeader, type: UTStopBoard.self)
        self.noDataLabel = try parse(optional: json, key: .NoDataLabel, type: UTStopBoard.self)
        self.color = try parse(optional: json, key:.Color, type: UTStopBoard.self) { try UTColor.fromJSON(optional: $0) }
        self.colorCompliment = try parse(optional: json, key: .ColorCompliment, type: UTStopBoard.self) { try UTColor.fromJSON(optional: $0) }
        try super.init(json: json)
    }

}