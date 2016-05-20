//
//  PlacePointType.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 26/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

/// The PlacePointType enum defines the possible place points that can be returned in by the API. The following are supported:
///
/// - Place - A place that doesn't fall into any of the other types
/// - Road
/// - TransitStop - A transit stop where there isn't more specific information about type of transit
/// - Postcode - Place defined by a postcode (zipcode)
/// - LatLng - A general location with a lat/lng position
/// - Locality - A locality
/// - POI - A Point of interest
/// - TransitStopTram - A tram transit stop
/// - TransitStopSubway - A subway transit stop
/// - TransitStopRail - A rail transit stop (station)
/// - TransitStopBus - A bus stop
/// - TransitStopFerry - A ferry terminal
/// - TransitStopCableCar - A cable car transit stop
/// - TransitStopGondola - A gondola transit stop
/// - TransitStopFunicular - A funicular transit stop
/// - TransitStopAir - An air transit stop, airport or heliport
/// - CycleHireDock - Cycle hire dock location
/// - CarParkingSpace - Car park

/// `PlacePointType` lists all valid types of place point.
@objc public enum PlacePointType : Int {
    /// A place that doesn't fall into any of the other PlacePointType options, raw value 0
    case Place = 0
    /// A road, raw value 1
    case Road = 1
    /// A transit stop that doesn't fall into any of the more specific PlacePointType options, raw value 2
    case TransitStop = 2
    /// A place defined by postcode (zipcode), raw value 3
    case Postcode = 3
    /// A place for a given lat/lng coordinate, raw value 4
    case LatLng = 4
    /// A place defining a locality, raw value 5
    case Locality = 5
    /// A point of interest, raw value 6
    case POI = 6
    /// A transit stop for trams, raw value 100
    case TransitStopTram = 100
    /// A subway transit stop, raw value 101
    case TransitStopSubway = 101
    /// A transit stop for rail (railway station), raw value 102
    case TransitStopRail = 102
    /// A bus transit stop, raw value 103
    case TransitStopBus = 103
    /// A ferry dock/port/terminal, raw value 104
    case TransitStopFerry = 104
    /// A place to start/end a cable car journey, raw value 105
    case TransitStopCableCar = 105
    /// A place to start/end a gondoal ride, raw value 106
    case TransitStopGondola = 106
    /// A place to start/end a funicular ride, raw value 107
    case TransitStopFunicular = 107
    /// A place to start an air journey, airport/heliport etc, raw value 108
    case TransitStopAir = 108
    /// A place to dock/undock a hire cycle, raw value 111
    case CycleHireDock = 111
    /// A place with parkings spaces, raw value 112
    case CarParkingSpace = 112
}
