//
//  UTTransitStopScheduledCall.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 09/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

class UTTransitStopScheduledCall: UTObject, TransitStopScheduledCall {
    
    /// The TransitStop at which the vehicle calls.
    let stop: TransitStop
    /// The time(s) at which the vehicle is scheduled to call and the type of call.
    let scheduledCall: TransitScheduledCall
    
    override init(json: [String : Any]) throws {
        self.stop = try parse(required: json, key: .Stop, type: UTTransitStopScheduledCall.self) as UTTransitStop
        self.scheduledCall = try parse(required: json, key:.ScheduledCall, type: UTTransitStopScheduledCall.self) as UTTransitScheduledCall
        try super.init(json: json)
    }
}
