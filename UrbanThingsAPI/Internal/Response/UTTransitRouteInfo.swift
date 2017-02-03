//
//  UTTransitRouteInfo.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 27/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import CoreLocation

class UTTransitRouteInfo : UTObject, TransitRouteInfo {
    
    let agencyCode:String?
    let routeID:String?
    let lineName:String?
    let lineColor:UTColor?
    let lineTextColor:UTColor?
    let operatorName:String?
    let operatorID:String?
    let operatorRegion:String?
    let routeType:TransitMode
    let centerPoint:Location?

    override init(json:[String:Any]) throws {
        self.agencyCode = try parse(optional:json, key: .AgencyCode, type: UTTransitRouteInfo.self)
        self.routeID = try parse(optional:json, key: .RouteID, type: UTTransitRouteInfo.self)
        self.lineName = try parse(optional:json, key: .LineName, type: UTTransitRouteInfo.self)
        self.lineColor = try parse(optional:json, key: .LineColor, type: UTTransitRouteInfo.self) { try UTColor.fromJSON(optional: $0) }
        self.lineTextColor = try parse(optional:json, key: .LineTextColor, type: UTTransitRouteInfo.self) { try UTColor.fromJSON(optional: $0) }
        self.operatorName = try parse(optional:json, key: .OperatorName, type: UTTransitRouteInfo.self)
        self.operatorID = try parse(optional:json, key: .OperatorID, type: UTTransitRouteInfo.self)
        self.operatorRegion = try parse(optional:json, key: .OperatorRegion, type: UTTransitRouteInfo.self)
        self.routeType = try parse(required: json, key: .RouteType, type: UTTransitRouteInfo.self)
        self.centerPoint = try parse(optional: json, type: UTTransitRouteInfo.self, property: "centerPoint") { try UTLocation(optional:$0, latitude: .CenterPointLat, longitude: .CenterPointLng) }
        try super.init(json:json)
    }
}

