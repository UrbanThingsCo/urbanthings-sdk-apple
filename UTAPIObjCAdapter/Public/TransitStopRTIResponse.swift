//
//  TransitStopRTIResponse.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 15/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation
import protocol UrbanThingsAPI.TransitStopRTIResponse

/// `TransitStopRTIResponse` extends an RTIResponse to provide details for transit stops.
@objc public protocol TransitStopRTIResponse : RTIResponse {
    
    /// One or more RTIReport objects making up the main part of this response.
    var rtiReports:[TransitStopRTIReport]? { get }
    
}

@objc public class UTTransitStopRTIResponse : UTRTIResponse, TransitStopRTIResponse {
    
    public init(adapt:UrbanThingsAPI.TransitStopRTIResponse) {
        self.rtiReports = adapt.rtiReports?.map { UTTransitStopRTIReport(adapt: $0) }
        super.init(adapt: adapt)
    }
    
    public let rtiReports:[TransitStopRTIReport]?
}