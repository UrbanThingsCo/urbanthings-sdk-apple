//
//  TransitStop.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 15/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation
import UTAPI

/// Defines a transit stop
///
/// Inherits from `PlacePoint`
@objc public protocol TransitStop : PlacePoint {
    
    /// A secondary code used to identify this TransitStop - whereas the PrimaryCode is often unique to this data ecosystem, the secondary code is likely to be unique only within the agency or data system that supplied it, optional.
    var additionalCode:String? { get }
    /// A code used for the retrieval of real time data via SMS, optional
    var smsCode:String? { get }
    var hasBearing:Bool { get }
    
    /// The compass bearing of vehicles leaving this stop, in degrees, optional
    var bearing:Int { get }
    /// A generic direction name for vehicles leaving this stop, e.g. *[towards] 'Marble Arch'*, optional
    var directionName:String? { get }
    /// A short textual series of numbers and/or letters to identify this stop in the physical world, e.g. 'A1'. In general these letters will be publicly displayed on or near the stop, optional.
    var stopIndicator:String? { get }
    /// Indicates permanent or temporary closure of the stop
    var isClosed:Bool { get }
    /// Mode of transport available from the stop
    var stopMode:TransitMode { get }
    /// Primary code of parent object
    var parentPrimaryCode: String? { get }
}

@objc public class UTTransitStop : UTPlacePoint, TransitStop {
    
    var transitStop:UTAPI.TransitStop { return super.adapted as! UTAPI.TransitStop }
    
    public init(adapt: UTAPI.TransitStop) {
        super.init(adapt: adapt)
    }
    
    public var additionalCode:String? { return self.transitStop.additionalCode }
    public var smsCode:String? { return self.transitStop.smsCode }
    public var hasBearing:Bool { return self.transitStop.bearing != nil }
    public var bearing:Int { return self.transitStop.bearing ?? 0 }
    public var directionName:String? { return self.transitStop.directionName }
    public var stopIndicator:String? { return self.transitStop.stopIndicator }
    public var isClosed:Bool { return self.transitStop.isClosed }
    public var stopMode:TransitMode { return self.transitStop.stopMode }
    public var parentPrimaryCode: String? { return self.transitStop.parentPrimaryCode }
}
