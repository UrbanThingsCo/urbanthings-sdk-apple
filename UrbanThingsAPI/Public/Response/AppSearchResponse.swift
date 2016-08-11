//
//  AppSearchResponse.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 02/08/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

public protocol Branding {
    var logoUrl: NSURL? { get }
    var primaryColor: UIColor { get }
    var primaryColorCompliment: UIColor { get }
    var secondaryColor: UIColor? { get }
    var secondaryColorCompliment: UIColor? { get }
}

class UTBranding: UTObject, Branding {
    let logoUrl: NSURL?
    let primaryColor: UIColor
    let primaryColorCompliment: UIColor
    let secondaryColor: UIColor?
    let secondaryColorCompliment: UIColor?
    override init(json: [String : AnyObject]) throws {
        self.logoUrl = try parse(optional:json, key: .LogoUrl, type: UTBranding.self) { try NSURL.fromJSON(required:$0) }
        self.primaryColor = try parse(required: json, key:.PrimaryColor, type: UTBranding.self) { try UTColor.fromJSON(required: $0) }
        self.primaryColorCompliment = try parse(required: json, key: .PrimaryColorCompliment, type: UTBranding.self) { try UTColor.fromJSON(required: $0) }
        self.secondaryColor = try parse(optional: json, key: .PrimaryColorCompliment, type: UTBranding.self) { try UTColor.fromJSON(optional: $0) }
        self.secondaryColorCompliment = try parse(optional: json, key: .PrimaryColorCompliment, type: UTBranding.self) { try UTColor.fromJSON(optional: $0) }
        try super.init(json: json)
    }
}

public protocol AgencyPresence {
    var kind: AgencyPresenceKind { get }
    var nature: AgencyPresenceNature { get }
    var value: String { get }
    var modifier: String? { get }
}

class UTAgencyPresence: UTObject, AgencyPresence {
    let kind: AgencyPresenceKind
    let nature: AgencyPresenceNature
    let value: String
    let modifier: String?

    override init(json: [String: AnyObject]) throws {
        self.kind = try parse(required: json, key: .Kind, type: UTAgencyPresence.self) { try AgencyPresenceKind(required: $0) }
        self.nature = try parse(required: json, key: .Nature, type: UTAgencyPresence.self) { try AgencyPresenceNature(required: $0) }
        self.value = try parse(required: json, key: .Value, type: UTAgencyPresence.self)
        self.modifier = try parse(optional: json, key: .Modifier, type: UTAgencyPresence.self)
        try super.init(json: json)
    }
}

public protocol Agency {
    var agencyId: String { get }
    var name: String { get }
    var displayName: String { get }
    var marketingDescription: String? { get }
    var timeZone: NSTimeZone? { get }
    var language: NSLocale? { get }
    var region: String? { get }
    var importSource: String? { get }
    var branding: Branding? { get }
    var presences: [AgencyPresence]? { get }
    var operatingAreaName: String? { get }
//    var operatingArea: GeoJSON { get }
}

class UTAgency: UTObject, Agency {
    let agencyId: String
    let name: String
    let displayName: String
    let marketingDescription: String?
    let timeZone: NSTimeZone?
    let language: NSLocale?
    let region: String?
    let importSource: String?
    let branding: Branding?
    let presences: [AgencyPresence]?
    let operatingAreaName: String?

    override init(json: [String : AnyObject]) throws {
        self.agencyId = try parse(required: json, key: .AgencyId, type: UTAgency.self)
        self.name = try parse(required: json, key: .Name, type: UTAgency.self)
        self.displayName = try parse(required: json, key: .DisplayName, type: UTAgency.self)
        self.marketingDescription = try parse(optional: json, key: .MarketingDescription, type: UTAgency.self)
        self.timeZone = try parse(optional: json, key: .TimeZone, type: UTAgency.self) { try NSTimeZone(optional: $0) }
        self.language = try parse(optional: json, key: .Language, type: UTAgency.self) { try NSLocale(optional: $0) }
        self.region = try parse(optional: json, key: .Region, type: UTAgency.self)
        self.importSource = try parse(optional: json, key: .ImportSource, type: UTAgency.self)
        self.branding = try parse(optional: json, key: .Branding, type: UTAgency.self) { try UTBranding(required: $0) as Branding }
        self.presences = try [UTAgencyPresence](optional: json[.Presences])?.map { $0 as AgencyPresence }
        self.operatingAreaName = try parse(optional: json, key: .OperatingAreaName, type: UTAgency.self)
        try super.init(json: json)
    }
}

public protocol ReferenceData {

    var agencies: [Agency] { get }

}

public protocol SearchPlace {
    var primaryCode: String { get }
    var name: String { get }
    var location: Location { get }
    var placePointType: PlacePointType { get }
    var locality: String { get }
    var iconUrl: NSURL? { get }
}

public protocol PlaceSearchResults {

    var results: [SearchPlace] { get }
    var noDataLabel: String? { get }

}

public protocol SearchRoute {
    var routeId: String { get }
    var agencyId: String { get }
    var name: String { get }
    var routeType: TransitMode { get }
    var routeDescription: String? { get }
    var centerPoint: Location { get }
}

public protocol RouteSearchResults {

    var results: [SearchRoute] { get }

}

public protocol AppSearchResponse {

    var placeSearchResults: PlaceSearchResults { get }
    var routeSearchResults: RouteSearchResults { get }
    var referenceData: ReferenceData { get }
    var attributionText: String? { get }
    var attributionImageUrl: NSURL? { get }
}

class UTSearchPlace: UTObject, SearchPlace {

    let primaryCode: String
    let name: String
    let location: Location
    let placePointType: PlacePointType
    let locality: String
    let iconUrl: NSURL?

    override init(json: [String : AnyObject]) throws {
        self.primaryCode = try parse(required: json, key: .PrimaryCode, type: UTSearchPlace.self)
        self.name = try parse(required: json, key: .Name, type: UTSearchPlace.self)
        self.locality = try parse(required: json, key: .Locality, type: UTSearchPlace.self)
        self.location = try UTLocation(required: json, key: .Location)
        self.placePointType = .Place
        self.iconUrl = try parse(optional:json, key: .IconUrl, type: UTSearchPlace.self) { try NSURL.fromJSON(required:$0) }
        try super.init(json: json)
    }
}

class UTSearchRoute: UTObject, SearchRoute {

    let routeId: String
    let agencyId: String
    let name: String
    let routeType: TransitMode
    let routeDescription: String?
    let centerPoint: Location

    override init(json: [String: AnyObject]) throws {
        self.routeId = try parse(required: json, key: .RouteId, type: UTSearchRoute.self)
        self.agencyId = try parse(required: json, key: .AgencyId, type: UTSearchRoute.self)
        self.name = try parse(required: json, key: .Name, type: UTSearchRoute.self)
        self.routeType = .Bus
        self.routeDescription = try parse(optional: json, key: .RouteDescription, type: UTSearchRoute.self)
        self.centerPoint = try parse(required: json, key: .CenterPoint, type: UTSearchRoute.self) { try UTLocation(required: $0) }
        try super.init(json: json)
    }
}

class UTPlaceSearchResults: UTObject, PlaceSearchResults {

    let results: [SearchPlace]
    let noDataLabel: String?

    override init(json: [String: AnyObject]) throws {
        self.results = try parse(required:json, key: .Results, type:UTPlaceSearchResults.self) { try [UTSearchPlace](required:$0) }.map { $0 as SearchPlace }
        self.noDataLabel = try parse(optional: json, key: .NoDataLabel, type:UTPlaceSearchResults.self)
        try super.init(json: json)
    }

}

class UTRouteSearchResults: UTObject, RouteSearchResults {

    let results: [SearchRoute]

    override init(json: [String: AnyObject]) throws {
        self.results = try parse(required:json, key: .Results, type:UTRouteSearchResults.self) { try [UTSearchRoute](required:$0) }.map { $0 as SearchRoute }
        try super.init(json: json)
    }
}

class UTReferenceData: UTObject, ReferenceData {

    let agencies: [Agency]

    override init(json: [String: AnyObject]) throws {
        self.agencies = try parse(required:json, key: .Agencies, type:UTReferenceData.self) { try [UTAgency](required:$0) }.map { $0 as Agency }
        try super.init(json: json)
    }
}

class UTAppSearchResponse: UTObject, AppSearchResponse {

    let placeSearchResults: PlaceSearchResults
    let routeSearchResults: RouteSearchResults
    let referenceData: ReferenceData
    let attributionText: String?
    let attributionImageUrl: NSURL?

    override init(json: [String : AnyObject]) throws {
        self.placeSearchResults = try parse(required: json, key: .PlaceSearchResults, type: UTAppSearchResponse.self) { try UTPlaceSearchResults(required: $0) as PlaceSearchResults }
        self.routeSearchResults = try parse(required: json, key: .RouteSearchResults, type: UTAppSearchResponse.self) { try UTRouteSearchResults(required: $0) as RouteSearchResults }
        self.referenceData = try parse(required: json, key: .ReferenceData, type: UTAppSearchResponse.self) { try UTReferenceData(required: $0) as ReferenceData }
        self.attributionText = try parse(optional: json, key:.AttributionText, type: UTAttribution.self)
        self.attributionImageUrl = try parse(optional:json, key:. AttributionImageUrl, type: UTAttribution.self) { try NSURL.fromJSON(optional:$0) }
        try super.init(json: json)
    }
}
