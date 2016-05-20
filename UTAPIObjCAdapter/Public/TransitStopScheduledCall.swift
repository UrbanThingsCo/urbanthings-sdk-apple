//
//  TransitStopScheduledCall.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 15/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation
import UTAPI

/// `TransitStopScheduledCall` details scheduled calls made at a given stop.
@objc public protocol TransitStopScheduledCall {
    
    /// The TransitStop at which the vehicle calls.
    var stop: TransitStop { get }
    /// The time(s) at which the vehicle is scheduled to call and the type of call.
    var scheduledCall: TransitScheduledCall { get }
    
}

@objc public class UTTransitStopScheduledCall : NSObject, TransitStopScheduledCall {
    
    let adapted: UTAPI.TransitStopScheduledCall
    
    public init(adapt: UTAPI.TransitStopScheduledCall) {
        self.adapted = adapt
        self.stop = UTTransitStop(adapt: adapt.stop)
        self.scheduledCall = UTTransitScheduledCall(adapt: adapt.scheduledCall)
    }
    
    public let stop: TransitStop
    public let scheduledCall: TransitScheduledCall
}