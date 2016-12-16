//
//  UTTransitDetailedRouteInfo.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 27/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

class UTTransitDetailedRouteInfo : UTTransitRouteInfo, TransitDetailedRouteInfo {
    
    let routeDescription:String?
    
    override init(json:[String:Any]) throws {
        self.routeDescription = try parse(optional:json, key: .RouteDescription, type: UTTransitDetailedRouteInfo.self)
        try super.init(json:json)
    }
}
