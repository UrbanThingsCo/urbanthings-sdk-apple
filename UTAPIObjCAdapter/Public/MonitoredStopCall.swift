//
//  MonitoredStopCall.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 15/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation
import UTAPI

/// `MonitoredStopCall` contains realtime information for a timetabled call at a transit stop.
@objc public protocol MonitoredStopCall : StopCall {
    /// The real time estimate of when this vehicle is expected to arrive at the stop.
    var expectedArrivalTime:NSDate? { get }
    /// The real time estimate of when this vehicle is expected to depart from the stop.
    var expectedDepartureTime:NSDate? { get }
    /// The real time estimate of the distance from the stop, along the route, that the vehicle is presently located at.
    var distanceMetres:Int { get }
    /// A value to aid presentation; this indicates whether a time based or distance based display is most appropriate.
    var masterDisplayFormat:MonitoredStopCallDisplayFormat { get }
    /// Any additional Real Time information for this vehicle - the delay field is not relevant in this context.
    var vehicleRTI:VehicleRTI { get }
    /// A label representing the platform at which the vehicle is expected to call when it arrives at this stop if applicable.
    var platform:String? { get }
    /// A flag to indicate if the vehicle's trip has been cancelled. If this is set to TRUE any conflicting real time information should be discarded.
    var isCancelled:Bool { get }
}

@objc public class UTMonitoredStopCall : UTStopCall, MonitoredStopCall {
    
    var monitoredStopCall:UTAPI.MonitoredStopCall { return self.adapted as! UTAPI.MonitoredStopCall }
    
    public init(adapt:UTAPI.MonitoredStopCall) {
        self.vehicleRTI = UTVehicleRTI(adapt: adapt.vehicleRTI)
        super.init(adapt: adapt)
    }
    
    public var expectedArrivalTime:NSDate? { return self.monitoredStopCall.expectedArrivalTime }
    public var expectedDepartureTime:NSDate? { return self.monitoredStopCall.expectedDepartureTime }
    public var distanceMetres:Int { return self.monitoredStopCall.distanceMetres ?? -1 }
    public var masterDisplayFormat:MonitoredStopCallDisplayFormat { return self.monitoredStopCall.masterDisplayFormat }
    public let vehicleRTI:VehicleRTI
    public var platform:String? { return self.monitoredStopCall.platform }
    public var isCancelled:Bool { return self.monitoredStopCall.isCancelled }
}
