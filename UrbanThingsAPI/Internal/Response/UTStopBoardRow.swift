//
//  UTStopBoardRow.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 03/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

class UTStopBoardRow : UTObject, StopBoardRow {
    
    let noteText:String? 
    let isRTI:Bool 
    let groupID:String? 
    let vehicleMode:TransitMode 
    let vehicleRegistrationText:String? 
    let trackingID:String? 
    let idLabel:String? 
    let mainLabel:String? 
    let secondaryLabel:String? 
    let platformLabel:String? 
    let timeMajorLabel:String? 
    let timeMinorLabel:String?

    override init(json: [String : Any]) throws {
        self.noteText = try parse(optional: json, key: .NoteText, type: UTStopBoardRow.self)
        self.isRTI = try parse(required: json, key: .IsRTI, type: UTStopBoardRow.self)
        self.groupID = try parse(optional: json, key: .GroupID, type: UTStopBoardRow.self)
        self.vehicleMode = try parse(required: json, key: .VehicleMode, type: UTStopBoardRow.self)
        self.vehicleRegistrationText = try parse(optional: json, key: .VehicleRegistrationText, type: UTStopBoardRow.self)
        self.trackingID = try parse(optional: json, key: .TrackingID, type: UTStopBoardRow.self)
        self.idLabel = try parse(optional: json, key: .IDLabel, type: UTStopBoardRow.self)
        self.mainLabel = try parse(optional: json, key: .MainLabel, type: UTStopBoardRow.self)
        self.secondaryLabel = try parse(optional: json, key: .SecondaryLabel, type: UTStopBoardRow.self)
        self.platformLabel = try parse(optional: json, key: .PlatformLabel, type: UTStopBoardRow.self)
        self.timeMajorLabel = try parse(optional: json, key: .TimeMajorLabel, type: UTStopBoardRow.self)
        self.timeMinorLabel = try parse(optional: json, key: .TimeMinorLabel, type: UTStopBoardRow.self)
        try super.init(json: json)
    }
}
