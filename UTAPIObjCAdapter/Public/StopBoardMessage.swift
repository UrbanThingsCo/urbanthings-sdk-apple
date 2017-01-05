//
//  StopBoardMessage.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 15/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation
import UTAPI

/// `StopBoardMessage` details a message to display on a stop board.
@objc public protocol StopBoardMessage : StopBoardColor {
    /// A brief, one-line summary of the message.
    var headerText:String? { get }
    /// The main text of the message.
    var mainText:String? { get }
    /// The URL of an graphic that represents this message, if available.
    var iconURL:URL? { get }
    /// The URL of a web page with further information relating to this message, if available.
    var linkURL:URL? { get }
    /// A piece of text that describes the content of the web page referred to in the linkURL field if applicable.
    var linkText:String? { get }
    /// Severity of distruption associated with the message.
    var severity:DisruptionSeverity { get }
}

@objc public class UTStopBoardMessage : UTStopBoardColor, StopBoardMessage {
    
    var stopBoardMessage: UTAPI.StopBoardMessage { return self.adapted as! UTAPI.StopBoardMessage }
    
    public init(adapt: UTAPI.StopBoardMessage) {
        super.init(adapt: adapt)
    }
    
    public var headerText:String? { return self.stopBoardMessage.headerText }
    public var mainText:String? { return self.stopBoardMessage.mainText }
    public var iconURL:URL? { return self.stopBoardMessage.iconURL }
    public var linkURL:URL? { return self.stopBoardMessage.linkURL }
    public var linkText:String? { return self.stopBoardMessage.linkText }
    public var severity:DisruptionSeverity { return self.stopBoardMessage.severity }
}
