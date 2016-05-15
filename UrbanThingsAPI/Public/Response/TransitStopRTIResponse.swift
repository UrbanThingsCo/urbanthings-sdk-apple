//
//  TransitStopRTIResponse.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 02/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

/// `TransitStopRTIResponse` extends an RTIResponse to provide details for transit stops.
public protocol TransitStopRTIResponse : RTIResponse {
    
    /// One or more RTIReport objects making up the main part of this response.
    var rtiReports:[TransitStopRTIReport]? { get }
    
}