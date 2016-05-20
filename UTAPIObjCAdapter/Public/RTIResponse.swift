//
//  RTIResponse.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 15/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation
import UTAPI

/// `RTIResponse` gives basic details for a real time response.
@objc public protocol RTIResponse : NSObjectProtocol {
    /// The PrimaryCode of the stop that this RTI Report has been generated for.
    var stopID:String { get }
    /// A string that indicates the reason why no RTIReport objects have been returned in this report, if applicable.
    var noDataLabel:String? { get }
    /// The data source for this report - may optionally be displayed by the client.
    var sourceName:String { get }
    
}

@objc public class UTRTIResponse : NSObject, RTIResponse {
    
    let adapted:UTAPI.RTIResponse
    
    public init(adapt:UTAPI.RTIResponse) {
        self.adapted = adapt
    }
    
    public var stopID:String { return self.adapted.stopID }
    public var noDataLabel:String? { return self.adapted.noDataLabel }
    public var sourceName:String { return self.adapted.sourceName }
}
