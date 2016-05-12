//
//  TransitStopScheduledCall.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 09/05/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

import Foundation

/// `TransitStopScheduledCall` details scheduled calls made at a given stop.
public protocol TransitStopScheduledCall {
    
    /// The TransitStop at which the vehicle calls.
    var stop: TransitStop { get }
    /// The time(s) at which the vehicle is scheduled to call and the type of call.
    var scheduledCall: TransitScheduledCall { get }
    
}