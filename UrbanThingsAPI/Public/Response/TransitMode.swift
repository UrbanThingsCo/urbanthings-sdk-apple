//
//  VehicleMode.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 26/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

/// The TransitMode enum defines possible modes of transit. The following modes are supported:
///
/// - Tram
/// - Subway
/// - Rail
/// - Bus
/// - Ferry
/// - CableCar
/// - Gondola
/// - Funicular
/// - Air
/// - Walking
/// - CycleOwned
/// - CycleHired
/// - Car
/// - Coach
/// - Multiple - Multiple transit modes used
/// - Unknown - Unknown transit system, none of the other available values are appropriate
/// - None - No transit system was specified

public enum TransitMode : Int {
    /// Transit by tram, Int value 0
    case Tram = 0
    /// Transit on subway system, raw value 1
    case Subway = 1
    /// Transit on rail network, raw value 2
    case Rail = 2
    /// Transit by bus, raw value 3
    case Bus = 3
    /// Transit by ferry, raw value 4
    case Ferry = 4
    /// Transit by cable car, raw value 5
    case CableCar = 5
    /// Transit by gondola, raw value 6
    case Gondola = 6
    /// Transit by funicular, raw value 7
    case Funicular = 7
    /// Transit by air, raw value 8
    case Air = 8
    /// Transit on foot, raw value 9
    case Walking = 9
    /// Transit using users cycle, raw value 10
    case CycleOwned = 10
    /// Transit using hired cycle, raw value 11
    case CycleHired = 11
    /// Transit by car, raw value 12
    case Car = 12
    /// Transit by coach, raw value 13
    case Coach = 13
    /// A vehicle powered by electricity
    case ElectricVehicle = 14
    /// Transit by multiple modes, raw value 9000
    case Multiple = 9000
    /// Unknown transit system, none of the other available values are appropriate, raw value 9999
    case Unknown = 9999
}
