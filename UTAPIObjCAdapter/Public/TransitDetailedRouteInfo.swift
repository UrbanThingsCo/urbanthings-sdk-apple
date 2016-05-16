//
//  TransitDetailedRouteInfo.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 15/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation
import protocol UrbanThingsAPI.TransitDetailedRouteInfo

/// Contains detailed information for a transit route.
///
/// Extends `TransitRouteInfo`
@objc public protocol TransitDetailedRouteInfo : TransitRouteInfo {
    /// Detailed description of the route, optional.
    var routeDescription:String? { get }
}

@objc public class UTTransitDetailedRouteInfo : UTTransitRouteInfo, TransitDetailedRouteInfo {
    
    var transitDetailedRouteInfo: UrbanThingsAPI.TransitDetailedRouteInfo { return self.adapted as! UrbanThingsAPI.TransitDetailedRouteInfo }
    
    public init?(adapt: UrbanThingsAPI.TransitDetailedRouteInfo) {
        super.init(adapt: adapt)
    }
    
    public var routeDescription: String? { return self.transitDetailedRouteInfo.routeDescription }
}
