//
//  DirectionsRequest.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 03/05/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

import Foundation

/// Enum that defines time for directions query
public enum DirectionsTime {
    /// Specifies a departure time for the directions query
    case Departure(NSDate)
    /// Specifies an arrival time for the directions query
    case Arrival(NSDate)
}

/// Enum that defines the travel mode for the directions query
public enum TravelMode: Int {
    /// Route using transit system
    case Transit = 0
    /// Route by driving a car
    case Driving = 1
    /// Route by cycling
    case Cycling = 2
    /// Route by walking
    case Walking = 3
}

/// Enum that defines the type of line that should be avioded.
public enum LineType: Int {
    /// Avoid routes that include toll roads
    case TollRoads = 0
    /// Avoid routes that include Highways
    case Highways = 1
}

/// Protocol defining accessibility options for directions query
public protocol DirectionsRequestAccessibilityOptions {
    /// If true will exclude and routes that require stairs
    var noStairs:Bool { get }
    /// If true will exclude and routes that require escalators
    var noEscalators:Bool { get }
    /// If true will exclude and routes that require elevators
    var noElevators:Bool { get }
    /// If true will exclude and routes that require steps to get on vehicle
    var noStepsToVehicle:Bool { get }
    /// If true will exclude and routes that require steps to access platform
    var noStepsToPlatform:Bool { get }
}

/// Protocol defining options that can be provided to a directions request
public protocol DirectionsRequestOptions {
    /// Agency code to limit directions to.
    var agencyCode:String? { get }
    /// Specifies the departure or arrival time for the request.
    var time:DirectionsTime? { get }
    /// Specifies the type of travel mode for the request.
    var travelContext:TravelMode { get }
    /// Specifies the maximum number of legs to complete the journey.
    var maximumLegs:UInt? { get }
    /// Specifies the walking speed to be used when calculating the journey.
    var walkSpeed:Float? { get }
    /// Specifies the maximum time allowed for walking between two consecutive legs.
    var maximumWalkingTimeBetweenLegs:UInt? { get }
    /// Specifies the maximum walking time for any walking leg.
    var maximumWalkingLegTime:UInt? { get }
    /// Specifies the maximum total walking time for a journey that statisfies the request.
    var maximumTotalWalkingTime:UInt? { get }
    /// Acceptable types of vehicle that can be used to satify the request.
    var acceptableVehicleTypes:[TransitMode]? { get }
    /// Kinds of line that should be avoided.
    var avoidedLineTypes:[LineType]? { get }
    /// Set to `true` to return polylines representing the geographical coordinates travelled along.
    var enableRouteGeometry:Bool { get }
    ///  Set to `true` to attempt to return additional real time planning and route information. This 
    /// option may not be respected by all planning engines.
    var enableRealtimeResults:Bool { get }
    /// Set to `true` to attempt to return any available information regarding fares and ticketing. This 
    /// option may not be respected by all planning engines.
    var enableFareResults:Bool { get }
}

/// Defines a direction request
public protocol DirectionsRequest : Request {
    
    associatedtype Result = DirectionsResponse
    
    /// The origin location where a planned journey should commence.
    var origin: PlacePoint { get }
    /// The destination location where a planned journey should end.
    var destination: PlacePoint { get }
    /// Structure detailing options for the request
    var options: DirectionsRequestOptions? { get }
    /// Structure detailing accessibility options for the request
    var accessibility: DirectionsRequestAccessibilityOptions? { get }
    /// General purpose dictionary for any parameters specific to a particular routing engine. Note that the values must be
    /// encodable as JSON.
    var customOptions: [String:AnyObject]? { get }
    /// The maximum number of journeys to find that fulfill the request.
    var maximumJourneys: UInt? { get }
}

/// Default implementation of `DirectionsRequestAccessibilityOptions` protocol provided by the API as standard means
/// of passing parameters to API request methods. You may provide your own implementation if needed to pass to the API
/// request methods.
public struct UTDirectionsRequestAccessibilityOptions: DirectionsRequestAccessibilityOptions {
    
    /// If true will exclude and routes that require stairs
    public let noStairs:Bool
    /// If true will exclude and routes that require escalators
    public let noEscalators:Bool
    /// If true will exclude and routes that require elevators
    public let noElevators:Bool
    /// If true will exclude and routes that require steps to get on vehicle
    public let noStepsToVehicle:Bool
    /// If true will exclude and routes that require steps to access platform
    public let noStepsToPlatform:Bool
    
    /// Initialize an instance of `UTDirectionsRequestAccessibilityOptions`
    ///
    ///  - parameters:
    ///    - noStairs: Whether or not to allow routes that require taking stairs.
    ///    - noEscalators: Whether or not to allow routes that require taking escalators.
    ///    - noElevators: Whether or not to allow routes that require taking elevators.
    ///    - noStepsToVehicle: Whether or not to allow routes that require taking steps to get on/off a vehicle.
    ///    - noStepsToPlatform: Whether or not to allow routes that require taking steps to get on/off a platform.
    public init(noStairs:Bool = false,
                noEscalators:Bool = false,
                noElevators:Bool = false,
                noStepsToVehicle:Bool = false,
                noStepsToPlatform:Bool = false) {
        self.noStairs = noStairs
        self.noEscalators = noEscalators
        self.noElevators = noElevators
        self.noStepsToVehicle = noStepsToVehicle
        self.noStepsToPlatform = noStepsToPlatform
    }
}

/// Default implementation of `DirectionsRequestOptions` protocol provided by the API as standard means
/// of passing parameters to API request methods. You may provide your own implementation if needed to pass to the API
/// request methods.
public struct UTDirectionsRequestOptions: DirectionsRequestOptions {
    
    /// Agency code to limit directions to.
    public let agencyCode:String?
    /// Specifies the departure or arrival time for the request.
    public let time:DirectionsTime?
    /// Specifies the type of travel mode for the request.
    public let travelContext:TravelMode
    /// Specifies the maximum number of legs to complete the journey.
    public let maximumLegs:UInt?
    /// Specifies the walking speed to be used when calculating the journey.
    public let walkSpeed:Float?
    /// Specifies the maximum time allowed for walking between two consecutive legs.
    public let maximumWalkingTimeBetweenLegs:UInt?
    /// Specifies the maximum walking time for any walking leg.
    public let maximumWalkingLegTime:UInt?
    /// Specifies the maximum total walking time for a journey that statisfies the request.
    public let maximumTotalWalkingTime:UInt?
    /// Acceptable types of vehicle that can be used to satify the request.
    public let acceptableVehicleTypes:[TransitMode]?
    /// Kinds of line that should be avoided.
    public let avoidedLineTypes:[LineType]?
    /// Set to `true` to return polylines representing the geographical coordinates travelled along.
    public let enableRouteGeometry:Bool
    /// Set to `true` to attempt to return additional real time planning and route information. This
    /// option may not be respected by all planning engines.
    public let enableRealtimeResults:Bool
    /// Set to `true` to attempt to return any available information regarding fares and ticketing. This
    /// option may not be respected by all planning engines.
    public let enableFareResults:Bool

    /// Initialize an instance of `UTDirectionsRequestOptions` for a departure time.
    ///
    ///  - parameters:
    ///    - departureTime: The departure time for the directions request.
    ///    - agencyCode: Agency code to limit directions to, optional.
    ///    - travelContext: Specifies the type of travel mode for the request, optional.
    ///    - maximumLegs: Specifies the maximum number of legs to complete the journey, optional.
    ///    - walkSpeed: Specifies the walking speed to be used when calculating the journey, optional.
    ///    - maximumWalkingTimeBetweenLegs: Specifies the maximum time allowed for walking between two consecutive legs, optional.
    ///    - maximumWalkingLegTime: Specifies the maximum walking time for any walking leg, optional.
    ///    - maximumTotalWalkingTime: Specifies the maximum total walking time for a journey that statisfies the request, optional.
    ///    - acceptableVehicleTypes: Specifies the acceptable types of vehicle that can be used to satify the request, optional.
    ///    - avoidedLineTypes: Set to `true` to return polylines representing the geographical coordinates travelled along.
    ///    - enableRouteGeometry: Set to `true` to return polylines representing the geographical coordinates travelled along.
    ///    - enableRealtimeResults: Set to `true` to attempt to return additional real time planning and route information. This
    /// option may not be respected by all planning engines.
    ///    - enableFareResults: Set to `true` to attempt to return any available information regarding fares and ticketing. This
    /// option may not be respected by all planning engines.
    public init(departureTime:NSDate,
                agencyCode:String? = nil,
                travelContext:TravelMode = .Transit,
                maximumLegs:UInt? = nil,
                walkSpeed:Float? = nil,
                maximumWalkingTimeBetweenLegs:UInt? = nil,
                maximumWalkingLegTime:UInt? = nil,
                maximumTotalWalkingTime:UInt? = nil,
                acceptableVehicleTypes:[TransitMode]? = nil,
                avoidedLineTypes:[LineType]? = nil,
                enableRouteGeometry:Bool = false,
                enableRealtimeResults:Bool = false,
                enableFareResults:Bool = false) {
        
        self.init(time: .Departure(departureTime),
                  agencyCode: agencyCode,
                  travelContext: travelContext,
                  walkSpeed: walkSpeed,
                  maximumWalkingTimeBetweenLegs: maximumWalkingTimeBetweenLegs,
                  maximumWalkingLegTime: maximumWalkingLegTime,
                  maximumTotalWalkingTime: maximumTotalWalkingTime,
                  acceptableVehicleTypes: acceptableVehicleTypes,
                  avoidedLineTypes: avoidedLineTypes,
                  enableRouteGeometry: enableRouteGeometry,
                  enableRealtimeResults: enableRealtimeResults,
                  enableFareResults: enableFareResults)
    }
    
    /// Initialize an instance of `UTDirectionsRequestOptions` for an arrival time.
    ///
    ///  - parameters:
    ///    - arrivalTime: The arrival time for the directions request.
    ///    - agencyCode: Agency code to limit directions to, optional.
    ///    - travelContext: Specifies the type of travel mode for the request, optional.
    ///    - maximumLegs: Specifies the maximum number of legs to complete the journey, optional.
    ///    - walkSpeed: Specifies the walking speed to be used when calculating the journey, optional.
    ///    - maximumWalkingTimeBetweenLegs: Specifies the maximum time allowed for walking between two consecutive legs, optional.
    ///    - maximumWalkingLegTime: Specifies the maximum walking time for any walking leg, optional.
    ///    - maximumTotalWalkingTime: Specifies the maximum total walking time for a journey that statisfies the request, optional.
    ///    - acceptableVehicleTypes: Specifies the acceptable types of vehicle that can be used to satify the request, optional.
    ///    - avoidedLineTypes: Set to `true` to return polylines representing the geographical coordinates travelled along.
    ///    - enableRouteGeometry: Set to `true` to return polylines representing the geographical coordinates travelled along.
    ///    - enableRealtimeResults: Set to `true` to attempt to return additional real time planning and route information. This
    /// option may not be respected by all planning engines.
    ///    - enableFareResults: Set to `true` to attempt to return any available information regarding fares and ticketing. This
    /// option may not be respected by all planning engines.
    public init(arrivalTime:NSDate,
                agencyCode:String? = nil,
                travelContext:TravelMode = .Transit,
                maximumLegs:UInt? = nil,
                walkSpeed:Float? = nil,
                maximumWalkingTimeBetweenLegs:UInt? = nil,
                maximumWalkingLegTime:UInt? = nil,
                maximumTotalWalkingTime:UInt? = nil,
                acceptableVehicleTypes:[TransitMode]? = nil,
                avoidedLineTypes:[LineType]? = nil,
                enableRouteGeometry:Bool = false,
                enableRealtimeResults:Bool = false,
                enableFareResults:Bool = false) {
        
        self.init(time: .Arrival(arrivalTime),
                  agencyCode: agencyCode,
                  travelContext: travelContext,
                  walkSpeed: walkSpeed,
                  maximumWalkingTimeBetweenLegs: maximumWalkingTimeBetweenLegs,
                  maximumWalkingLegTime: maximumWalkingLegTime,
                  maximumTotalWalkingTime: maximumTotalWalkingTime,
                  acceptableVehicleTypes: acceptableVehicleTypes,
                  avoidedLineTypes: avoidedLineTypes,
                  enableRouteGeometry: enableRouteGeometry,
                  enableRealtimeResults: enableRealtimeResults,
                  enableFareResults: enableFareResults)
    }
    
    /// Initialize an instance of `UTDirectionsRequestOptions` with departure time of 'now'.
    ///
    ///  - parameters:
    ///    - arrivalTime: The arrival time for the directions request.
    ///    - agencyCode: Agency code to limit directions to, optional.
    ///    - travelContext: Specifies the type of travel mode for the request, optional.
    ///    - maximumLegs: Specifies the maximum number of legs to complete the journey, optional.
    ///    - walkSpeed: Specifies the walking speed to be used when calculating the journey, optional.
    ///    - maximumWalkingTimeBetweenLegs: Specifies the maximum time allowed for walking between two consecutive legs, optional.
    ///    - maximumWalkingLegTime: Specifies the maximum walking time for any walking leg, optional.
    ///    - maximumTotalWalkingTime: Specifies the maximum total walking time for a journey that statisfies the request, optional.
    ///    - acceptableVehicleTypes: Specifies the acceptable types of vehicle that can be used to satify the request, optional.
    ///    - avoidedLineTypes: Set to `true` to return polylines representing the geographical coordinates travelled along.
    ///    - enableRouteGeometry: Set to `true` to return polylines representing the geographical coordinates travelled along.
    ///    - enableRealtimeResults: Set to `true` to attempt to return additional real time planning and route information. This
    /// option may not be respected by all planning engines.
    ///    - enableFareResults: Set to `true` to attempt to return any available information regarding fares and ticketing. This
    /// option may not be respected by all planning engines.
    public init(travelContext:TravelMode = .Transit,
                agencyCode:String?,
                maximumLegs:UInt? = nil,
                walkSpeed:Float? = nil,
                maximumWalkingTimeBetweenLegs:UInt? = nil,
                maximumWalkingLegTime:UInt? = nil,
                maximumTotalWalkingTime:UInt? = nil,
                acceptableVehicleTypes:[TransitMode]? = nil,
                avoidedLineTypes:[LineType]? = nil,
                enableRouteGeometry:Bool = false,
                enableRealtimeResults:Bool = false,
                enableFareResults:Bool = false) {
        
        self.init(time: nil,
                  agencyCode: agencyCode,
                  travelContext: travelContext,
                  walkSpeed: walkSpeed,
                  maximumWalkingTimeBetweenLegs: maximumWalkingTimeBetweenLegs,
                  maximumWalkingLegTime: maximumWalkingLegTime,
                  maximumTotalWalkingTime: maximumTotalWalkingTime,
                  acceptableVehicleTypes: acceptableVehicleTypes,
                  avoidedLineTypes: avoidedLineTypes,
                  enableRouteGeometry: enableRouteGeometry,
                  enableRealtimeResults: enableRealtimeResults,
                  enableFareResults: enableFareResults)
    }
    
    init(time:DirectionsTime? = .Departure(NSDate()),
         agencyCode:String? = nil,
         travelContext:TravelMode = .Transit,
         maximumLegs:UInt? = nil,
         walkSpeed:Float? = nil,
         maximumWalkingTimeBetweenLegs:UInt? = nil,
         maximumWalkingLegTime:UInt? = nil,
         maximumTotalWalkingTime:UInt? = nil,
         acceptableVehicleTypes:[TransitMode]? = nil,
         avoidedLineTypes:[LineType]? = nil,
         enableRouteGeometry:Bool = false,
         enableRealtimeResults:Bool = false,
         enableFareResults:Bool = false) {
        
        self.time = time
        self.agencyCode = agencyCode
        self.travelContext = travelContext
        self.maximumLegs = maximumLegs
        self.walkSpeed = walkSpeed
        self.maximumWalkingTimeBetweenLegs = maximumWalkingTimeBetweenLegs
        self.maximumWalkingLegTime = maximumWalkingLegTime
        self.maximumTotalWalkingTime = maximumTotalWalkingTime
        self.acceptableVehicleTypes = acceptableVehicleTypes
        self.avoidedLineTypes = avoidedLineTypes
        self.enableRouteGeometry = enableRouteGeometry
        self.enableRealtimeResults = enableRealtimeResults
        self.enableFareResults = enableFareResults
    }
}

/// Default implementation of `DirectionsRequest` protocol provided by the API as standard means
/// of passing parameters to API request methods. You may provide your own implementation if needed to pass to the API
/// request methods.
public struct UTDirectionsRequest : DirectionsRequest {
    
    public typealias Result = DirectionsResponse
    public typealias Parser = (json:AnyObject?, logger:Logger) throws -> Result
    
    /// The origin location where a planned journey should commence.
    public let origin: PlacePoint
    /// The destination location where a planned journey should end.
    public let destination: PlacePoint
    /// Structure detailing options for the request
    public let options: DirectionsRequestOptions?
    /// Structure detailing accessibility options for the request
    public let accessibility: DirectionsRequestAccessibilityOptions?
    /// General purpose dictionary for any parameters specific to a particular routing engine. Note that the values must be
    /// encodable as JSON.
    public let customOptions: [String:AnyObject]?
    /// The maximum number of journeys to find that fulfill the request.
    public let maximumJourneys: UInt?

    /// Parser that will be used to process server response
    public let parser:Parser
    
    /// Initialize an instance of `UTDirectionsRequest`
    ///
    ///  - parameters:
    ///    - origin: PlacePoint providing the start of the directions request
    ///    - destination: PlacePoint providing the end of the directions request
    ///    - options: Optional instance of the `DirectionsRequestOptions` protocol providing options to the request
    ///    - accessibility: Optional instance of the `DirectionsRequestAccessibilityOptions` protocol providing 
    /// accessibility options to the request
    ///    - customOptions: Optional general purpose dictionary for any parameters specific to a particular routing 
    /// engine. Note that the values must be encodable as JSON.
    ///    - maximumJourneys: The maximum number of journeys to find that fulfill the request.
    public init(origin: PlacePoint, destination:PlacePoint, options: DirectionsRequestOptions? = nil, accessibility:DirectionsRequestAccessibilityOptions? = nil, customOptions:[String:AnyObject]? = nil, maximumJourneys:UInt? = nil, parser: Parser = urbanThingsParser) {
    
        self.parser = parser
        self.origin = origin
        self.destination = destination
        self.options = options
        self.accessibility = accessibility
        self.customOptions = customOptions
        self.maximumJourneys = maximumJourneys
    }
}

extension Dictionary where Key : StringLiteralConvertible, Value : AnyObject {

    subscript(key:QueryKey) -> Value? {
        get {
            return self[key.description as! Key]
        }
        set {
            guard newValue != nil else {
                return
            }
            self[key.description as! Key] = newValue!
        }
    }
}

extension PlacePoint {
    func toJSONObject() throws -> [String:AnyObject] {
        var json:[String:AnyObject] = [:]
        json[.Lat] = self.location.latitude
        json[.Lng] = self.location.longitude
        json[.Name] = self.name
        json[.PrimaryCode] = self.primaryCode
        return json
    }
}

extension NSDate {

    private static var token:dispatch_once_t = 0
    private static var dateFormatter:NSDateFormatter?
    
    var asISO8601:String {
        dispatch_once(&NSDate.token) {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
            NSDate.dateFormatter = formatter
        }
        
        return NSDate.dateFormatter!.stringFromDate(self)
    }
}

extension DirectionsRequest {

    func toJSON() throws -> NSData {
        var json:[String:AnyObject] = [:]
        json[.Origin] = try self.origin.toJSONObject()
        json[.Destination] = try self.destination.toJSONObject()
        if let time = self.options?.time {
            switch time {
            case .Departure(let date):
                json[.DepartureTime] = date.asISO8601
                break
            case .Arrival(let date):
                json[.ArrivalTime] = date.asISO8601
                break
            }
        } else {
            json[.DepartureTime] = NSDate().asISO8601
        }
        json[.AgencyCode] = self.options?.agencyCode
        var custom = [String:AnyObject]()
        custom[.KeyValues] = self.customOptions
        json[.CustomOptions] = custom
        json[.EnableRouteGeometry] = self.options?.enableRouteGeometry
        json[.EnableRealtimeResults] = self.options?.enableRealtimeResults
        json[.EnableFareResults] = self.options?.enableFareResults
        json[.TravelContext] = self.options?.travelContext.rawValue
        json[.MaximumJourneys] = self.maximumJourneys
        var options = [String:AnyObject]()
        options[.MaximumLegs] = self.options?.maximumLegs
        options[.WalkSpeed] = self.options?.walkSpeed
        options[.MaximumWalkingLegTime] = self.options?.maximumWalkingLegTime
        options[.MaximumWalkingTimeBetweenLegs] = self.options?.maximumWalkingTimeBetweenLegs
        options[.MaximumTotalWalkingTime] = self.options?.maximumTotalWalkingTime
        options[.AcceptableVehicleTypes] = self.options?.acceptableVehicleTypes?.map { $0.rawValue }
        options[.AvoidedLineTypes] = self.options?.avoidedLineTypes?.map { $0.rawValue }
        options[.AccessibilityNoStairs] = self.accessibility?.noStairs
        options[.AccessibilityNoEscalators] = self.accessibility?.noEscalators
        options[.AccessibilityNoElevators] = self.accessibility?.noElevators
        options[.AccessibilityNoStepsToVehicle] = self.accessibility?.noStepsToVehicle
        options[.AccessibilityNoStepsToPlatform] = self.accessibility?.noStepsToPlatform
        json[.Options] = options
        return try NSJSONSerialization.dataWithJSONObject(json, options:[])
    }
}
