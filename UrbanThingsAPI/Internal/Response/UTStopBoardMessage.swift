//
//  UTStopBoardMessage.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 03/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

class UTStopBoardMessage : UTObject, StopBoardMessage {

    let headerText:String? 
    let mainText:String? 
    let iconURL:NSURL?
    let linkURL:NSURL?
    let linkText:String? 
    let severity:DisruptionSeverity
    let color:UTColor?
    let colorCompliment:UTColor?

    override init(json: [String : AnyObject]) throws {
        self.headerText = try parse(optional: json, key: .HeaderText, type: UTStopBoardMessage.self)
        self.mainText = try parse(optional: json, key: .MainText, type: UTStopBoardMessage.self)
        self.linkText = try parse(optional: json, key: .LinkText, type: UTStopBoardMessage.self)
        self.iconURL = try parse(optional:json, key:. IconURL, type: UTStopBoardMessage.self) { try NSURL.fromJSON(optional:$0) }
        self.linkURL = try parse(optional:json, key:. LinkURL, type: UTStopBoardMessage.self) { try NSURL.fromJSON(optional:$0) }
        self.color = try parse(optional: json, key: .Color, type: UTStopBoardMessage.self) { try UTColor.fromJSON(optional: $0) }
        self.colorCompliment = try parse(optional: json, key: .ColorCompliment, type: UTStopBoardMessage.self) { try UTColor.fromJSON(optional: $0) }
        self.severity = try parse(required: json, key: .Severity, type: UTStopBoardMessage.self)
        try super.init(json: json)
    }
}
