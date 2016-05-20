//
//  RTIResponse.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 03/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation


/// `RTIResponse` gives basic details for a real time response.
public protocol RTIResponse {
    /// The PrimaryCode of the stop that this RTI Report has been generated for.
    var stopID:String { get }
    /// A string that indicates the reason why no RTIReport objects have been returned in this report, if applicable.
    var noDataLabel:String? { get }
    /// The data source for this report - may optionally be displayed by the client.
    var sourceName:String { get }
    
}