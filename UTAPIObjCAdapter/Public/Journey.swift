//
//  Journey.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 15/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation
import UTAPI

/// `Journey` defines a journey that fulfills a directions request
@objc public protocol Journey {
    /// Arrival time for the journey.
    var arrivalTime:NSDate? { get }
    /// Departure time for the journey.
    var departureTime:NSDate? { get }
    /// Summary text for the journey with HTML formatting.
    var summaryHTML:String? { get }
    /// Duration of the journey in seconds if available, will be zero if no information provided.
    var duration:UInt { get }
    /// Array of JourneyLeg instances that make up the journey.
    var legs:[JourneyLeg] { get }
    /// Place point ID of the place of origin for the journey.
    var originPlacePointID:String? { get }
    /// Place point ID of the destination for the journey.
    var destinationPlacePointID:String? { get }
}

@objc public class UTJourney : NSObject, Journey {
    
    let adapted:UTAPI.Journey
    
    public init(adapt:UTAPI.Journey) {
        self.adapted = adapt
        self.legs = [] //
    }
    
    public var arrivalTime:NSDate? { return self.adapted.arrivalTime }
    public var departureTime:NSDate? { return self.adapted.departureTime }
    public var summaryHTML:String? { return self.adapted.summaryHTML }
    public var duration:UInt { return self.adapted.duration ?? 0 }
    public let legs:[JourneyLeg]
    public var originPlacePointID:String? { return self.adapted.originPlacePointID }
    public var destinationPlacePointID:String? { return self.adapted.destinationPlacePointID }
}
