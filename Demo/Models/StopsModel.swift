//
//  StopsModel.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 06/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation
import UTAPI
import CoreLocation

// Replace string with your API key, available by registering at
// https://portal-bristol.api.urbanthings.io/#/signup
let ApiKey = "YOUR_API_KEY"

/// Notification that is sent whenever there is a data update received from the server.
let StopDataUpdated = "StopDataUpdated"
/// Notification that is sent whenever there there is a location change due to the
/// user selecting a new location
let LocationChanged = "LocationChanged"
/// Notification that a transit stop was selected
let TransitStopSelected = "TransitStopSelected"
/// User info key for transit stop code in TransitStopSelected notification
let TransitStopPrimaryCode = "TransitStopPrimaryCode"

let Unavailable = "Unavailable"

/// Some timing constants
let GroupingTimeWindow = 0.5
let GroupingRequiredDelay = 0.1
let CacheExpiryTime = 60.0

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
var _sharedInstance: StopsModel = {
    return StopsModel()
}()

/// StopModel is a singleton that manages the app state and provides notifications whenever
/// state changes
class StopsModel {
    
    static var sharedInstance: StopsModel = {
        return StopsModel()
    }()
    
    /// The supported locations for the demo app
    let demoLocations:[DemoLocation] = [
        DemoLocation(title: "UrbanThings", lat: UrbanThingsLocation.latitude, lng: UrbanThingsLocation.longitude),
        DemoLocation(title: "Bath, UK", lat:51.3820000, lng:-2.3617200),
        DemoLocation(title: "Watershed", lat:51.4536802, lng:-2.596403),
        DemoLocation(title: "New York", lat:40.71427, lng: -74.00597),
        ]
    
    // Initialize an API instance. Store as the protocol so that seperate implementation can be substituted without
    // needing to make any other changes to code
    let api:UrbanThingsAPIType = UrbanThingsAPI(service: UTService(endpoint: "https://bristol.api.urbanthings.io/api",
                                                                   version: "2.0",
                                                                   key: ApiKey))
    
    // Setup dispatch queue for barrier use
    let readWriteQueue: DispatchQueue = DispatchQueue(label: "io.urbanthings.api.demo", attributes: .concurrent)
    
    /// Current data is stored here, its private so that we can enforce
    /// thread safe access through use of dispatch barrier
    private var internalData:[UTAPI.TransitStop] = []
    var data:[UTAPI.TransitStop] {
        get {
            var currentData:[UTAPI.TransitStop] = []
            readWriteQueue.sync {
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
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: LocationChanged), object: nil)
        }
        
        // Start a new request
        currentRequest = api.send(request: UTTransitStopsRequest(center:location, radius:1000, stopModes:types)) { data, error in
            
            // Update with result of call through dispatch barrier to ensure thread
            // safe access
            self.readWriteQueue.sync(flags: .barrier) {
                self.internalData = data ?? []
            }
            // Notify app that new data is available
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: StopDataUpdated), object: nil)
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
    
    // MARK: Deferred requests
    
    // A request item holds a stopID and a completion handler
    private class RequestItem {
        let stopID:String
        let completion:(String?) -> Void
        
        init(stopID:String, completion: @escaping (String?) -> Void) {
            self.stopID = stopID
            self.completion = completion
        }
    }
    
    // Request is returned for each client request. However this refers to
    // one shared request that may be for multiple items. This implementation
    // redirects to the shared request
    private struct Request : UrbanThingsAPIRequest {
        let item:RequestItem
        var deferred:DeferredGroup
        
        func cancel() {
            let _ = deferred.cancel(item: item)
        }
    }
    
    // Deferred group manages a set of requests batching multiple stops into
    // one request
    private class DeferredGroup {
        
        var deferred = [RequestItem]()
        let readWriteQueue: DispatchQueue
        var request:UrbanThingsAPIRequest?
        
        init(readWriteQueue: DispatchQueue) {
            self.readWriteQueue = readWriteQueue
        }
        
        // Adds an item to the group
        func add(stopID:String, completion: @escaping (String?) -> Void) -> UrbanThingsAPIRequest {
            let requestItem = RequestItem(stopID:stopID, completion: completion)
            if self.request != nil {
                assertionFailure("Cannot add to group after request made")
            }
            self.deferred.append(requestItem)
            return Request(item:requestItem, deferred:self)
        }
        
        func start(api:UrbanThingsAPIType, cache: @escaping (_ stopID:String, _ message:String) -> Void) {
            self.readWriteQueue.async {
                // If no items just return
                if self.deferred.count == 0 {
                    return
                }
                
                self.request = api.send(request: UTRealtimeResourcesStatusRequest(stopIDs:self.deferred.map { $0.stopID })) { data, error in
                    self.readWriteQueue.async(flags: .barrier) {
                        if let data = data {
                            var map = [String:RequestItem]()
                            self.deferred.forEach { map[$0.stopID] = $0 }
                            data.forEach {
                                // Lets call some ObjC code, so we adapt the pure swift object
                                // and pass to ObjC method
                                ObjCDemo.logStatus(UTAPIObjCAdapter.UTResourceStatus(adapt: $0))
                                if let item = map[$0.primaryCode] {
                                    let msg = $0.statusText ?? Unavailable
                                    item.completion(msg)
                                    cache($0.primaryCode, msg)
                                }
                            }
                        } else {
                            self.deferred.forEach {
                                $0.completion(Unavailable)
                                cache($0.stopID, Unavailable)
                            }
                        }
                    }
                }
            }
        }
        
        // Cancel a single item request, if its the last being managed
        // stop the actual request
        func cancel(item:RequestItem) -> Bool {
            var ret:Bool = false
            // Attempt to get an existing value from the cache
            self.readWriteQueue.sync {
                self.deferred = self.deferred.filter { $0 !== item }
                ret = self.deferred.count == 0
            }
            return ret
        }
    }
    
    // Dictionary to cache resource status for primary stop code
    private var cache:[String:ResourceStatus] = [:]
    
    // For collating close requests, time of last request
    // and array of stopID and completionHandler pairs
    private var lastRequestTime = Date.distantPast
    private var deferredGroup:DeferredGroup?
    
    // Method to get resource status of a stop asynchronously
    //
    //  - parameters:
    //    - stop: The transit stop of interest
    //    - completion: Completion handler that will be called with result of call when completed
    func getStopResources(stop:UTAPI.TransitStop, completion: @escaping (String?) -> Void) -> UrbanThingsAPIRequest? {
        var existing:ResourceStatus?
        
        // Attempt to get an existing value from the cache
        self.readWriteQueue.sync {
            existing = self.cache[stop.primaryCode]
        }
        
        // If there was one and its not expired pass back in completion handler and we are done
        if let existing = existing {
            if existing.timestamp.timeIntervalSinceNow >= -60 {
                completion(existing.status)
                return nil
            }
        }
        
        var ret:UrbanThingsAPIRequest?
        
        self.readWriteQueue.sync(flags: .barrier) {
            let group:DeferredGroup? = self.deferredGroup ?? DeferredGroup(readWriteQueue:self.readWriteQueue)
            ret = group?.add(stopID: stop.primaryCode, completion: completion)
            if self.lastRequestTime.timeIntervalSinceNow > -GroupingTimeWindow {
                if self.deferredGroup == nil {
                    self.deferredGroup = group
                    Timer.scheduledTimer(timeInterval: max(GroupingRequiredDelay, GroupingTimeWindow + self.lastRequestTime.timeIntervalSinceNow), target: self, selector: #selector(self.timer), userInfo: nil, repeats: false)
                }
            } else {
                self.deferredGroup = group
                self.start()
            }
        }
        
        return ret
    }
    
    // Start a deferred group request
    func start() {
        self.deferredGroup?.start(api: self.api) { code, message in
            self.cache[code] = ResourceStatus(status: message)
        }
        self.lastRequestTime = Date()
        self.deferredGroup = nil
    }
    
    // Called when time window for grouping expires to trigger
    // request for grouped stops
    @objc func timer(timer: Timer) {
        self.readWriteQueue.sync(flags: .barrier) {
            self.start()
        }
    }

    // Test if a key has been edited into source
    func hasValidApiKey() -> Bool {
        return !ApiKey.contains("API_KEY")
    }
}
