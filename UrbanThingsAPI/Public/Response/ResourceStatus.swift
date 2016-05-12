//
//  ResourceStatus.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 26/04/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

import Foundation

/// `ResourceTrend` details the trend for a resource that provides status.
public enum ResourceTrend: Int {
    /// Trend is static, not changing.
    case Static = 0
    /// Trend is filling, that is less of the resource will be available as time progresses.
    case Filling = 1
    /// Trend is emptying, that is more of the resource will be available as time progresses.
    case Emptying = 2
}

/// `ResourceStatus` details the status of a resource.
public protocol ResourceStatus : Attribution {
    /// Primary code for the resource.
    var primaryCode:String { get }
    /// Import source ID detailing where the status information is being obtained from.
    var importSourceID:String { get }
    /// Timestamp detailing time that the data applies to.
    var timestamp:NSDate { get }
    /// A text message detailing the current status if available/applicable.
    var statusText:String? { get }
    /// Number of available places at the resource.
    var availablePlaces:Int { get }
    /// Number of taken places at the resources.
    var takenPlaces:Int { get }
    /// Whether or not the resource is currently closed.
    var isClosed:Bool { get }
    /// Capacity trend for the resource if available.
    var trend:ResourceTrend? { get }
    /// Custom status code that is specific to the particular resource, if used or avialable.
    var customStatusCode:Int? { get }
    /// Type of vehicle the resource applies to, for example HireCycle for cycle hire dock, Car for car park.
    var vehicleType:TransitMode { get }
}