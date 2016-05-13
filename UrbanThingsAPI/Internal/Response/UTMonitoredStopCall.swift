//
//  UTMonitoredStopCall.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 02/05/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

import Foundation

class UTMonitoredStopCall : UTStopCall, MonitoredStopCall {
    
    let expectedArrivalTime: NSDate?
    let expectedDepartureTime: NSDate?
    let distanceMetres: Int?
    let masterDisplayFormat: MonitoredStopCallDisplayFormat
    let vehicleRTI: [VehicleRTI]
    let platform: String?
    let isCancelled: Bool

    override init(json: [String : AnyObject]) throws {
        self.expectedArrivalTime = try String(optional: json[.ExpectedArrivalTime])?.requiredDate()
        self.expectedDepartureTime = try String(optional: json[.ExpectedDepartureTime])?.requiredDate()
        self.platform = try parse(optional: json, key: .Platform, type: UTMonitoredStopCall.self)
        self.isCancelled = try parse(required: json, key: .IsCancelled, type: UTMonitoredStopCall.self)
        self.distanceMetres = try parse(optional: json, key: .DistanceMetres, type: UTMonitoredStopCall.self)
        self.masterDisplayFormat = try parse(required: json, key: .MasterDisplayFormat, type: UTMonitoredStopCall.self)
        self.vehicleRTI = try parse(required:json, key: .VehicleRTI, type:UTMonitoredStopCall.self) { try [UTVehicleRTI](required:$0) }.map { $0 as VehicleRTI }
        try super.init(json: json)
    }
}
