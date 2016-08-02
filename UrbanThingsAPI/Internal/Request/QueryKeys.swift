//
//  s.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 29/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

enum QueryKey: String {
    case LineName = "lineName"
    case ExactMatch = "exactMatch"
    case ImportSource = "importsource"
    case AgencyID = "agencyid"
    case AgencyRegion = "agencyRegion"
    case CenterLat = "centerLat"
    case CenterLng = "centerLng"
    case Radius = "radius"
    case MinLat = "minLat"
    case MinLng = "minLng"
    case MaxLat = "maxLat"
    case MaxLng = "maxLng"
    case Lat = "lat"
    case Lng = "lng"
    case Country = "country"
    case PlacePointTypes = "placepointtypes"
    case MaxResults = "maxresults"
    case StopName = "stopName"
    case StopIDs = "stopIDs"
    case StopModes = "stopModes"
    case Name = "name"
    case MaxResultsPerType = "maxResultsPerType"
    case TripID = "tripID"
    case RouteID = "routeID"
    case OriginStopID = "originStopID"
    case DestStopID = "destStopID"
    case IncludePolylines = "includePolylines"
    case IncludeStopCoordinates = "includeStopCoordinates"
    case StopID = "stopID"
    case QueryTime = "queryTime"
    case LookAheadMinutes = "lookAheadMinutes"
    case MaximumItems = "maxItems"
    case VehiclePassingType = "vehiclePassingType"
    case Use24HourClock = "use24HourClock"
    case PrimaryCode = "primaryCode"
    case Origin = "origin"
    case Destination = "destination"
    case CustomOptions = "customOptions"
    case KeyValues = "keyValues"
    case EnableRouteGeometry = "enableRouteGeometry"
    case EnableRealtimeResults = "enableRealtimeResults"
    case EnableFareResults = "enableFareResults"
    case AgencyCode = "agencyCode"
    case TravelContext = "travelContext"
    case MaximumJourneys = "maximumJourneys"
    case Options = "options"
    case MaximumLegs = "maximumLegs"
    case WalkSpeed = "walkSpeed"
    case MaximumWalkingTimeBetweenLegs = "maximumWalkingTimeBetweenLegs"
    case MaximumWalkingLegTime = "maximumWalkingLegTime"
    case MaximumTotalWalkingTime = "maximumTotalWalkingTime"
    case AcceptableVehicleTypes = "acceptableVehicleTypes"
    case AvoidedLineTypes = "avoidedLineTypes"
    case AccessibilityNoStairs = "accessibilityNoStairs"
    case AccessibilityNoEscalators = "accessibilityEscalators"
    case AccessibilityNoElevators = "accessibilityElevators"
    case AccessibilityNoStepsToVehicle = "accessibilityNoStepsToVehicle"
    case AccessibilityNoStepsToPlatform = "accessibilityNoStepsToPlatform"
    case DepartureTime = "departureTime"
    case ArrivalTime = "arrivalTime"
    case Query = "query"
    case Latitude = "latitude"
    case Longitude = "longitude"
}

extension QueryKey : CustomStringConvertible {
    var description: String {
        return self.rawValue
    }
}
