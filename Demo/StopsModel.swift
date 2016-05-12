//
//  StopsModel.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 06/05/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

import Foundation
import UrbanThingsAPI
import CoreLocation

// Replace string with your API key
let ApiKey = "A valid API key"

/// Notification that is sent whenever there is a data update received from the server.
let StopDataUpdated = "StopDataUpdated"
/// Notification that is sent whenever there there is a location change due to the 
/// user selecting a new location
let LocationChanged = "LocationChanged"

let TransitStopSelected = "TransitStopSelected"

let TransitStopPrimaryCode = "TransitStopPrimaryCode"

/// Structure to store the available locations in the app
struct DemoLocation {
    let location:Location
    let title:String
    
    init(title:String, lat:Double, lng:Double) {
        self.title = title
        self.location = CLLocationCoordinate2D(latitude:lat, longitude:lng)
    }
}

/// Location of the UrbanThings office
let UrbanThingsLocation = CLLocationCoordinate2D(latitude: 51.5291205, longitude: -0.0802295)

/// StopModel is a singleton that manages the app state and provides notifications whenever
/// state changes
class StopsModel {

    /// Property to access singleton in a thread safe way
    class var sharedInstance: StopsModel {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: StopsModel? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = StopsModel()
        }
        return Static.instance!
    }

    /// The supported locations for the demo app
    let demoLocations:[DemoLocation] = [
        DemoLocation(title: "UrbanThings", lat: UrbanThingsLocation.latitude, lng: UrbanThingsLocation.longitude),
        DemoLocation(title: "Bath, UK", lat:51.3820000, lng:-2.3617200),
        DemoLocation(title: "Watershed", lat:51.4536802, lng:-2.596403),
        DemoLocation(title: "New York", lat:40.71427, lng: -74.00597),
    ]
    
    // Initialize an API instance. Store as the protocol so that seperate implementation can be substituted without
    // needing to make any other changes to code
    let api:UrbanThingsAPIType = UrbanThingsAPI(apiKey: ApiKey)

    // Setup dispatch queue for barrier use
    let readWriteQueue:dispatch_queue_t = dispatch_queue_create("io.urbanthings.api.demo", DISPATCH_QUEUE_CONCURRENT)
    
    /// Current data is stored here, its private so that we can enforce
    /// thread safe access through use of dispatch barrier
    private var internalData:[TransitStop] = []
    var data:[TransitStop] {
        get {
            var currentData:[TransitStop] = []
            dispatch_sync(readWriteQueue) {
                currentData = self.internalData
            }
            return currentData
        }
    }
    
    /// Current location
    var location:Location?
    
    /// Current transit stops request if any
    private var currentRequest:UrbanThingsAPIRequest?

    /// Sets a new location and/or filter for the app data model. A change triggers a re-request of data
    /// from the server.
    func setLocation(location:Location, types:[TransitMode] = [TransitMode.Car, TransitMode.CycleHired]) {

        // Cancel any existing request as we are going to superceed with a new one
        currentRequest?.cancel()

        // If location has changed notify app
        if location.latitude != self.location?.latitude || location.longitude != self.location?.longitude {
            self.location = location
            NSNotificationCenter.defaultCenter().postNotificationName(LocationChanged, object: nil)
        }

        // Start a new request
        currentRequest = api.sendRequest(UTTransitStopsRequest(center:location, radius:1000, stopModes:types)) { data, error in
            
            // Update with result of call through dispatch barrier to ensure thread
            // safe access
            dispatch_barrier_sync(self.readWriteQueue) {
                self.internalData = data ?? []
            }
            // Notify app that new data is available
            NSNotificationCenter.defaultCenter().postNotificationName(StopDataUpdated, object: nil)
        }
    }

    // Structure used to cache resources status
    private struct ResourceStatus {
        let timestamp = NSDate()
        let status:String?
        
        init(status:String?) {
            self.status = status
        }
    }
    
    // Dictionary to cache resource status for primary stop code
    private var cache:[String:ResourceStatus] = [:]
    
    // Method to get resource status of a stop asynchronously
    //
    //  - parameters:
    //    - stop: The transit stop of interest
    //    - completion: Completion handler that will be called with result of call when completed
    func getStopResources(stop:TransitStop, completion:(String?) -> Void) -> UrbanThingsAPIRequest? {
        var existing:ResourceStatus?
        
        // Attempt to get an existing value from the cache
        dispatch_sync(self.readWriteQueue) {
            existing = self.cache[stop.primaryCode]
        }
        
        // If ther was one and its not expired pass back in completion handler and we are done
        if let existing = existing {
            if existing.timestamp.timeIntervalSinceNow >= -60 {
                completion(existing.status)
                return nil
            }
        }
        
        // We need to request to get latest status for the transit stop
        return api.sendRequest(UTRealtimeResourceStatusRequest(stopID: stop.primaryCode)) { (data, error) in
            // If no error need to save latest value into cache safely
            if error == nil {
                dispatch_barrier_sync(self.readWriteQueue) {
                    self.cache[stop.primaryCode] = ResourceStatus(status: data?.statusText)
                }
            }
            // Send the latest value
            completion(data?.statusText)
        }
    }
}
