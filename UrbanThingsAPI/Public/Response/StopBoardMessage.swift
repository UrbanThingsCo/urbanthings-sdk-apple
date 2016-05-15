//
//  StopBoardMessageType.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 26/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

/// `StopBoardMessage` details a message to display on a stop board.
public protocol StopBoardMessage : StopBoardColor {
    /// A brief, one-line summary of the message.
    var headerText:String? { get }
    /// The main text of the message.
    var mainText:String? { get }
    /// The URL of an graphic that represents this message, if available.
    var iconURL:NSURL? { get }
    /// The URL of a web page with further information relating to this message, if available.
    var linkURL:NSURL? { get }
    /// A piece of text that describes the content of the web page referred to in the linkURL field if applicable.
    var linkText:String? { get }
    /// Severity of distruption associated with the message.
    var severity:DisruptionSeverity { get }
}