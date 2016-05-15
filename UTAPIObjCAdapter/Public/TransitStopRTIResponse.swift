//
//  TransitStopRTIResponse.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 15/05/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

import Foundation


/// `TransitStopRTIResponse` extends an RTIResponse to provide details for transit stops.
@objc public protocol TransitStopRTIResponse : RTIResponse {
    
    /// One or more RTIReport objects making up the main part of this response.
    var rtiReports:[TransitStopRTIReport]? { get }
    
}