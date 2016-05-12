//
//  TransitStop.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 26/04/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

import Foundation

/// Defines a transit stop
///
/// Inherits from `PlacePoint`
public protocol TransitStop : PlacePoint {
    
    /// A secondary code used to identify this TransitStop - whereas the PrimaryCode is often unique to this data ecosystem, the secondary code is likely to be unique only within the agency or data system that supplied it, optional.
    var additionalCode:String? { get }
    /// A code used for the retrieval of real time data via SMS, optional
    var smsCode:String? { get }
    /// The compass bearing of vehicles leaving this stop, in degrees, optional
    var bearing:Int? { get }
    /// A generic direction name for vehicles leaving this stop, e.g. *[towards] 'Marble Arch'*, optional
    var directionName:String? { get }
    /// A short textual series of numbers and/or letters to identify this stop in the physical world, e.g. 'A1'. In general these letters will be publicly displayed on or near the stop, optional.
    var stopIndicator:String? { get }
    /// Indicates permanent or temporary closure of the stop
    var isClosed:Bool { get }
    /// Mode of transport available from the stop
    var stopMode:TransitMode { get }
}