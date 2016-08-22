//
//  QueryParameters.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 27/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

public typealias QueryParameters = [QueryKey:QueryParameter]

public enum QueryParameter {
    public init(_ value: Any?) {
        if let value = value {
            if let array = value as? [Any] {
                self = .Array(array)
            } else if let array = value as? [AnyObject] {
                self = .Array(array)
            } else if let array = value as? NSArray {
                self = .Array(array.map {$0 as Any})
            } else {
                self = .Value(value)
            }
        } else {
            self = .Nil
        }
    }

    case Value(Any)
    case Array([Any])
    case Nil
}

extension QueryParameter : CustomStringConvertible {
    public var description: String {
        switch self {
        case .Nil:
            return ""
        case .Value(let v):
            return "\(v)"
        case .Array(let a):
            return a.map { "\($0)" }.joinWithSeparator(",")
        }
    }
}

extension Dictionary {

    var description: String {
        let params = self
            .map { (k, v) in ("\(k)", "\(v)") }
            .filter { (k, v) in v.characters.count > 0 }
            .map { (k, v) in "\(k)=\(v.stringByURLEncodingAsQueryParameterValue())" }
            .joinWithSeparator("&")
        if params.characters.count > 0 {
            return "?" + params
        }
        return params
    }
}

func +(lhs: QueryParameters, rhs: QueryParameters) -> QueryParameters {

    var result = lhs
    rhs.forEach { (k, v) in
        if let existing = result[k] {
            result[k] = QueryParameter.Array([existing, v].map {
                switch $0 {
                case .Value(let v):
                    return QueryParameter.Array([v])
                case .Array(let a):
                    return a
                case .Nil:
                    return []
                }
                }.flatMap { $0 })
        } else {
            result[k] = v
        }
    }
    return result
}

extension TransitRoutesByLineNameRequest {
    public var queryParameters: QueryParameters {
        return [QueryKey.LineName:QueryParameter(lineName),
                QueryKey.ExactMatch:QueryParameter(exactMatch),
                QueryKey.AgencyRegion:QueryParameter(agencyRegion)]
            + requiredParameters.queryParameters
    }
}

extension TransitRoutesImportSource {
    public var queryParameters: QueryParameters {
        switch self {
        case AgencyID(let agencyID):
            return [QueryKey.AgencyID: QueryParameter(agencyID)]
        case ImportSource(let source):
            return [QueryKey.ImportSource: QueryParameter(source)]
        }
    }
}

extension TransitRoutesByImportSourceRequest {
    public var queryParameters: QueryParameters {
        return self.source.queryParameters
    }
}

extension TransitRoutesByStopRequest {
    public var queryParameters: QueryParameters {
        return [QueryKey.StopID: QueryParameter.Value(stopID)]
    }
}

extension TransitAgencyRequest {
    public var queryParameters: QueryParameters {
        return [QueryKey.AgencyID:QueryParameter.Value(agencyID)]
    }
}

extension AreaFilter {
    var queryParameters: QueryParameters {
        switch self {
        case .Circle(let center, let radius):
            return [QueryKey.CenterLat:QueryParameter(center.latitude),
                    QueryKey.CenterLng:QueryParameter(center.longitude),
                    QueryKey.Radius:QueryParameter(radius)]
        case .Rectangle(let topLeft, let bottomRight):
            return [QueryKey.MinLat:QueryParameter(min(topLeft.latitude, bottomRight.latitude)),
                    QueryKey.MinLng:QueryParameter(max(topLeft.longitude, bottomRight.longitude)),
                    QueryKey.MaxLat:QueryParameter(max(topLeft.latitude, bottomRight.latitude)),
                    QueryKey.MaxLng:QueryParameter(max(topLeft.longitude, bottomRight.longitude))]
        }
    }
}

extension RouteOrTripID {
    var queryParameters: QueryParameters {
        switch self {
        case .RouteID(let routeID):
            return [QueryKey.RouteID: QueryParameter(routeID)]
        case .TripID(let tripID):
            return [QueryKey.TripID: QueryParameter(tripID)]
        }
    }
}

extension TransitTripsRequest {
    public var queryParameters: QueryParameters {
        return routeOrTripID.queryParameters +
            [QueryKey.OriginStopID:QueryParameter(originStopID),
             QueryKey.DestStopID:QueryParameter(destinationStopID),
             QueryKey.IncludePolylines:QueryParameter(includePolylines),
             QueryKey.IncludeStopCoordinates:QueryParameter(includeStopCoordinates)]
    }
}

extension TransitAgenciesRequest {
    public var queryParameters: QueryParameters {
        return [QueryKey.ImportSource:QueryParameter.Value(importSource)]
    }
}

extension TransitTripGroupsRequest {
    public var queryParameters: QueryParameters {
        return [QueryKey.RouteID:QueryParameter(routeID),
                QueryKey.IncludePolylines: QueryParameter(includePolylines),
                QueryKey.IncludeStopCoordinates: QueryParameter(includeStopCoordinates)]
    }
}

extension RealtimeResourceStatusRequest {
    public var queryParameters: QueryParameters {
        return [QueryKey.StopIDs: QueryParameter(stopID)]
    }
}

extension RealtimeResourcesStatusRequest {
    public var queryParameters: QueryParameters {
        return [QueryKey.StopIDs: QueryParameter(stopIDs)]
    }
}

extension LocationFilter {
    var queryParameters: QueryParameters {
        switch self {
        case .Point(let point, let country):
            return [QueryKey.Lat:QueryParameter(point.latitude),
                    QueryKey.Lng:QueryParameter(point.longitude),
                    QueryKey.Country:QueryParameter(country)]
        case .Country(let country):
            return [QueryKey.Country:QueryParameter(country)]
        }
    }
}

extension PlacePointsRequest {
    public var queryParameters: QueryParameters {
        return area.queryParameters +
            [QueryKey.PlacePointTypes:QueryParameter(placepointTypes?.map { $0.rawValue }),
             QueryKey.MaxResults:QueryParameter(maximumResults)]
    }
}

extension TransitStopsRequest {
    public var queryParameters: QueryParameters {
        return area.queryParameters +
            [QueryKey.StopName:QueryParameter(stopName),
             QueryKey.ImportSource:QueryParameter(importSource),
             QueryKey.StopIDs:QueryParameter(stopIDs),
             QueryKey.StopModes:QueryParameter(stopModes?.map { $0.rawValue }),
             QueryKey.MaxResults:QueryParameter(maximumResults)]
    }
}

extension PlacesListRequest {
    public var queryParameters: QueryParameters {
        return self.location.queryParameters + [QueryKey.Name:QueryParameter(name),
                                                QueryKey.PlacePointTypes:QueryParameter(placePointTypes?.map { $0.rawValue }),
                                                QueryKey.MaxResultsPerType:QueryParameter(maximumResultsPerType)]
    }
}

extension TransitStopCallsRequest {
    public var queryParameters: QueryParameters {
        return [QueryKey.StopID: QueryParameter(stopID),
                QueryKey.QueryTime: QueryParameter(queryTime),
                QueryKey.LookAheadMinutes: QueryParameter(lookAheadMinutes)]
    }
}

extension RealtimeReportRequest {
    public var queryParameters: QueryParameters {
        return [QueryKey.StopID: QueryParameter(stopID),
                QueryKey.LookAheadMinutes: QueryParameter(lookAheadMinutes),
                QueryKey.MaximumItems: QueryParameter(maximumItems)]
    }
}

extension RealtimeStopboardRequest {
    public var queryParameters: QueryParameters {
        return [QueryKey.StopID: QueryParameter(stopID),
                QueryKey.MaximumItems: QueryParameter(maximumItems),
                QueryKey.VehiclePassingType: QueryParameter(vehiclePassingType),
                QueryKey.Use24HourClock: QueryParameter(use24HourClock)]
    }
}

extension TransitRoutesByLineRequiredParameters {
    public var queryParameters: QueryParameters {
        switch self {
        case Location(let location, let agencyID, let importSource):
            return [QueryKey.Lat: QueryParameter(location.latitude),
                    QueryKey.Lng: QueryParameter(location.longitude),
                    QueryKey.AgencyID: QueryParameter(agencyID),
                    QueryKey.ImportSource: QueryParameter(importSource)]
        case AgencyID(let agencyID, let location, let importSource):
            return [QueryKey.Lat: QueryParameter(location?.latitude),
                    QueryKey.Lng: QueryParameter(location?.longitude),
                    QueryKey.AgencyID: QueryParameter(agencyID),
                    QueryKey.ImportSource: QueryParameter(importSource)]
        case ImportSource(let importSource, let location, let agencyID):
            return [QueryKey.Lat: QueryParameter(location?.latitude),
                    QueryKey.Lng: QueryParameter(location?.longitude),
                    QueryKey.AgencyID: QueryParameter(agencyID),
                    QueryKey.ImportSource: QueryParameter(importSource)]
        }
    }
}
