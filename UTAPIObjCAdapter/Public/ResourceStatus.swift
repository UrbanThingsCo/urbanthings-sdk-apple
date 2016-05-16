//
//  ResourceStatus.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 15/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation
import protocol UrbanThingsAPI.ResourceStatus
import enum UrbanThingsAPI.TransitMode
import enum UrbanThingsAPI.ResourceTrend

/// `ResourceTrend` details the trend for a resource that provides status.
@objc public enum ResourceTrend: Int {
    /// This resource doesn't current provide trend information
    case Unavailable = -1
    /// Trend is static, not changing.
    case Static = 0
    /// Trend is filling, that is less of the resource will be available as time progresses.
    case Filling = 1
    /// Trend is emptying, that is more of the resource will be available as time progresses.
    case Emptying = 2
    
    init(_ value: UrbanThingsAPI.ResourceTrend?) {
        self = ResourceTrend(rawValue: value?.rawValue ?? -1) ?? .Unavailable
    }
}

/// `ResourceStatus` details the status of a resource.
@objc public protocol ResourceStatus : Attribution {
    /// Primary code for the resource.
    var primaryCode:String { get }
    /// Import source ID detailing where the status information is being obtained from.
    var importSourceID:String { get }
    /// Timestamp detailing time that the data applies to.
    var timestamp:NSDate { get }
    /// A text message detailing the current status if available/applicable.
    var statusText:String? { get }
    var hasPlaceInformation: Bool { get }
    /// Number of available places at the resource.
    var availablePlaces:Int { get }
    /// Number of taken places at the resources.
    var takenPlaces:Int { get }
    /// Whether or not the resource is currently closed.
    var isClosed:Bool { get }
    /// Capacity trend for the resource if available.
    var trend:ResourceTrend { get }
    var hasCustomStatusCode: Bool { get }
    /// Custom status code that is specific to the particular resource, if used or avialable.
    var customStatusCode:Int { get }
    /// Type of vehicle the resource applies to, for example HireCycle for cycle hire dock, Car for car park.
    var vehicleType:TransitMode { get }
}

@objc public class UTResourceStatus: UTAttribution {
    
    var resourceStatus: UrbanThingsAPI.ResourceStatus { return self.adapted as! UrbanThingsAPI.ResourceStatus }
    
    public init(adapt: UrbanThingsAPI.ResourceStatus) {
        self.trend = ResourceTrend(adapt.trend)
        super.init(adapt: adapt)
    }
    
    public var primaryCode:String { return self.resourceStatus.primaryCode }
    public var importSourceID:String { return self.resourceStatus.importSourceID }
    public var timestamp:NSDate { return self.resourceStatus.timestamp }
    public var statusText:String? { return self.resourceStatus.statusText }
    public var hasPlaceInformation: Bool { return self.resourceStatus.availablePlaces != nil && self.resourceStatus.takenPlaces != nil }
    public var availablePlaces:Int { return self.resourceStatus.availablePlaces ?? 0 }
    public var takenPlaces:Int { return self.resourceStatus.takenPlaces ?? 0 }
    public var isClosed:Bool { return self.resourceStatus.isClosed }
    public let trend:ResourceTrend
    public var hasCustomStatusCode: Bool { return self.resourceStatus.customStatusCode != nil }
    public var customStatusCode:Int { return self.resourceStatus.customStatusCode ?? 0 }
    public var vehicleType:TransitMode { return self.resourceStatus.vehicleType }
}
