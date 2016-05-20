//
//  TransitStopScheduledCallSummary.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 15/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation
import CoreLocation
import UTAPI

public let InvalidDegrees:Double = 360

/// `TransitStopScheduledCallSummary` provides summary details of a single call at a given transit stop.
@objc public protocol TransitStopScheduledCallSummary : NSObjectProtocol {
    /// The primaryCode of the TransitStop at which the vehicle calls.
    var transitStopPrimaryCode:String { get }
    /// The name of the TransitStop at which the vehicle calls.
    var transitStopName:String? { get }
    /// The locality Name of the TransitStop at which the vehicle calls.
    var transitStopLocalityName:String? { get }
    /// The time(s) at which the vehicle is scheduled to call and the type of call.
    var scheduledCall:TransitScheduledCall { get }
    /// The geo location of this TransitStop, if available. If not available will be CLLocationCoordinate2DInvalid.
    var transitStopLocation:CLLocationCoordinate2D { get }
}

@objc public class UTTransitStopScheduledCallSummary : NSObject, TransitStopScheduledCallSummary {
    
    let adapted:UTAPI.TransitStopScheduledCallSummary
    
    public init(adapt:UTAPI.TransitStopScheduledCallSummary) {
        self.adapted = adapt
        self.transitStopLocation = CLLocationCoordinate2D(latitude: adapt.transitStopLocation?.latitude ?? InvalidDegrees, longitude: adapt.transitStopLocation?.latitude ?? InvalidDegrees)
        self.scheduledCall = UTTransitScheduledCall(adapt: adapt.scheduledCall)
    }
    
    public var transitStopPrimaryCode:String { return self.adapted.transitStopPrimaryCode }
    public var transitStopName:String? { return self.adapted.transitStopName }
    public var transitStopLocalityName:String? { return self.adapted.transitStopLocalityName }
    public let scheduledCall:TransitScheduledCall
    public let transitStopLocation:CLLocationCoordinate2D
}