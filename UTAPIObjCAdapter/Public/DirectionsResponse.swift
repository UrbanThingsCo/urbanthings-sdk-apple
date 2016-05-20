//
//  DirectionsResponse.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 15/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation
import UTAPI

@objc public protocol DirectionsResponse {
    /// Unique identifier for the response
    var responseID:String? { get }
    /// Status of the response as a `DirectionsResponseStatus` instance
    var status:DirectionsResponseStatus { get }
    /// Array of `Journey` instances detailing the journies found for the route request.
    var journeys:[Journey]? { get }
    /// Array of `PlacePoint` instances providing the place points used in the journeys.
    var placePoints:[PlacePoint]? { get }
    /// Name of source for the route (the routing engine)
    var sourceName:String? { get }
    /// String in HTML to display as attribution for the routing data.
    var attributionsHTML:String? { get }
    /// String in HTML to display as a general warning with the route.
    var warningsHTML:String? { get }
}

@objc public class UTDirectionsResponse : NSObject, DirectionsResponse {
    
    let adapted:UTAPI.DirectionsResponse
    
    public init(adapt:UTAPI.DirectionsResponse) {
        self.adapted = adapt
        self.status = UTDirectionsResponseStatus(adapt: adapt.status)
        self.journeys = adapt.journeys?.map { UTJourney(adapt:$0) }
        self.placePoints = adapt.placePoints?.map { UTPlacePoint(adapt:$0) }
    }
    
    public var responseID:String? { return self.adapted.responseID }
    public let status:DirectionsResponseStatus
    public let journeys:[Journey]?
    public let placePoints:[PlacePoint]?
    public var sourceName:String? { return self.adapted.sourceName }
    public var attributionsHTML:String? { return self.adapted.attributionsHTML }
    public var warningsHTML:String? { return self.adapted.warningsHTML }
}
