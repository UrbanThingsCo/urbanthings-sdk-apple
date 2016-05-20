//
//  DirectionsResponseStatus.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 15/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation
import UTAPI

/// Defines status data for the response from a directions requests.
@objc public protocol DirectionsResponseStatus : NSObjectProtocol {
    /// Status code
    var statusCode:Int { get }
    /// Error code
    var errorCode:Int { get }
    /// Error message string
    var errorMessage:String? { get }
}

@objc public class UTDirectionsResponseStatus : NSObject, DirectionsResponseStatus {
    
    let adapted:UTAPI.DirectionsResponseStatus
    
    public init(adapt:UTAPI.DirectionsResponseStatus) {
        self.adapted = adapt
        super.init()
    }
    
    public var statusCode:Int { return self.adapted.statusCode }
    public var errorCode:Int { return self.adapted.errorCode }
    public var errorMessage:String? { return self.adapted.errorMessage }
}
