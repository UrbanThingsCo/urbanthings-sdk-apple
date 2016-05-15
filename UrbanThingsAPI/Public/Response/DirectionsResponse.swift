//
//  DirectionsResponseType.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 26/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

/// Defines properties for the response from a directions requests
public protocol DirectionsResponse {
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