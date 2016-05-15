//
//  JourneyLeg.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 26/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

/// `JourneyLeg` protocol describes a journey leg. `Inherited by TransitJourneyLeg`.
public protocol JourneyLeg {
    /// A localized instruction, in HTML, displayed to the user in journey planning results, e.g. Take the 126 bus towards Heathrow.
    var summaryHTML:String? { get }
    /// Place point ID of the point of origin for the leg
    var originPlacePointID:String? { get }
    /// Place point ID of the destination point for the leg
    var destinationPlacePointID:String? { get }
    /// Time of arrival at the destination point
    var arrivalTime:NSDate? { get }
    /// Time of departure from the origin point
    var departureTime:NSDate? { get }
    /// Type of vehicle used for the leg, eg bus, car etc.
    var vehicleType:TransitMode { get }
    /// Estimated duration of the leg in seconds, if available.
    var duration:UInt? { get }
    /// Approximate distance of the leg in metres if applicable (for example walking).
    var distance:UInt? { get }
    /// Google polyline string, if requested and available
    var polyline:String? { get }
}
