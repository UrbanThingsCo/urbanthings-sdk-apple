//
//  UrbanThingsAPIType.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 26/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

/// UrbanThingsAPIRequest provides access to a request initiated through the API and allows cancellation. If a call is cancelled
/// no further response through the result closure will occur.
public protocol UrbanThingsAPIRequest {
    /// Cancel the operation relating to this instance
    func cancel()
}

/// Protocol defining the API, primarily so that mock implementations can be provided for testing purposes. To make a request
/// to the server use `sendRequest` method passing in the required `Request` object. The completion handler will receive
/// either a concrete instance of the expected response object or an error. You will never receive both a response object and
/// error.
///
/// ````
/// apiInstance.sendRequest(UTImportSourceRequest()) 
///         { data, error in //... }
/// ````
public protocol UrbanThingsAPIType {
    
    /// Make an asynchronous request to the server for a list of import sources.
    ///
    ///  - parameters:
    ///    - request: Object that implements the `ImportSourceRequest` protocol, see `UTImportSourceRequest` for concrete
    /// implementation that can be used, alternatively provide your own.
    ///    - completionHandler: Closure that is called when call has completed and response processed. Will either provide the
    /// data as an array of `ImportSource` objects or an error, but never both.
    @warn_unused_result(message="Returned request object needed to cancel async operation")
    func sendRequest<R : ImportSourcesRequest>(request:R, completionHandler:(data:R.Result?, error:ErrorType?) -> Void) -> UrbanThingsAPIRequest

    /// Make an asynchronous request to the server for a list of transport stops
    ///
    ///  - parameters:
    ///    - request: An object that implements the `TransitStopRequest` protocol, see `UTTransitStopRequest` for concrete
    /// implementation that can be used, alternatively provide your own.
    ///    - completionHandler: Closure that is called when call has completed and response processed. Will either provide the
    /// data as an array of `TransitStop` objects or an error, but never both.
    @warn_unused_result(message="Returned request object needed to cancel async operation")
    func sendRequest<R : TransitStopsRequest>(request:R, completionHandler:(data:R.Result?, error:ErrorType?) -> Void) -> UrbanThingsAPIRequest

    /// Make an asynchronous request to the server for a list of place points
    ///
    ///  - parameters:
    ///    - request: An object that implements the `PlacePointsRequest` protocol, see `UTPlacePointsRequest` for concrete
    /// implementation that can be used, alternatively provide your own.
    ///    - completionHandler: Closure that is called when call has completed and response processed. Will either provide the
    /// data as a `PlacePointList` object or an error, but never both.
    @warn_unused_result(message="Returned request object needed to cancel async operation")
    func sendRequest<R : PlacePointsRequest>(request:R, completionHandler:(data:R.Result?, error:ErrorType?) -> Void) -> UrbanThingsAPIRequest

    /// Make an asynchronous request to the server for a list of places
    ///
    ///  - parameters:
    ///    - request: An object that implements the `PlacesListRequest` protocol, see `UTPlacesListRequest` for concrete
    /// implementation that can be used, alternatively provide your own.
    ///    - completionHandler: Closure that is called when call has completed and response processed. Will either provide the
    /// data as a `PlacePointList` object or an error, but never both.
    @warn_unused_result(message="Returned request object needed to cancel async operation")
    func sendRequest<R : PlacesListRequest>(request:R, completionHandler:(data:R.Result?, error:ErrorType?) -> Void) -> UrbanThingsAPIRequest

    /// Make an asynchronous request to the server for a list of transit routes for a given transit line name.
    ///
    ///  - parameters:
    ///    - request: An object that implements the `TransitRoutesByLineNameRequest` protocol, see `UTTransitRoutesByLineNameRequest` for concrete
    /// implementation that can be used, alternatively provide your own.
    ///    - completionHandler: Closure that is called when call has completed and response processed. Will either provide the
    /// data as a `TransitDetailedRouteInfo` object or an error, but never both.
    @warn_unused_result(message="Returned request object needed to cancel async operation")
    func sendRequest<R : TransitRoutesByLineNameRequest>(request:R, completionHandler:(data:R.Result?, error:ErrorType?) -> Void) -> UrbanThingsAPIRequest

    /// Make an asynchronous request to the server for a list of transit routes for a given source
    ///
    ///  - parameters:
    ///    - request: An object that implements the `TransitRouteSourceRequest` protocol, see `UTTransitRouteSourceRequest` for concrete
    /// implementation that can be used, alternatively provide your own.
    ///    - completionHandler: Closure that is called when call has completed and response processed. Will either provide the
    /// data as a `TransitDetailedRouteInfo` object or an error, but never both.
    @warn_unused_result(message="Returned request object needed to cancel async operation")
    func sendRequest<R : TransitRoutesByImportSourceRequest>(request:R, completionHandler:(data:R.Result?, error:ErrorType?) -> Void) -> UrbanThingsAPIRequest
    
    /// Make an asynchronous request to the server for a list of transit routes calling at a specific transit stop
    ///
    ///  - parameters:
    ///    - request: An object that implements the `TransitRoutesByStopRequest` protocol, see `UTTransitRoutesByStopRequest` for concrete
    /// implementation that can be used, alternatively provide your own.
    ///    - completionHandler: Closure that is called when call has completed and response processed. Will either provide the
    /// data as a `TransitDetailedRouteInfo` object or an error, but never both.
    @warn_unused_result(message="Returned request object needed to cancel async operation")
    func sendRequest<R : TransitRoutesByStopRequest>(request:R, completionHandler:(data:R.Result?, error:ErrorType?) -> Void) -> UrbanThingsAPIRequest

    /// Make an asynchronous request to the server for a transit agency
    ///
    ///  - parameters:
    ///    - request: An object that implements the `TransitAgencyRequest` protocol, see `UTTransitAgencyRequest` for concrete
    /// implementation that can be used, alternatively provide your own.
    ///    - completionHandler: Closure that is called when call has completed and response processed. Will either provide the
    /// data as a `TransitAgency` object or an error, but never both.
    @warn_unused_result(message="Returned request object needed to cancel async operation")
    func sendRequest<R : TransitAgencyRequest>(request:R, completionHandler:(data:R.Result?, error:ErrorType?) -> Void) -> UrbanThingsAPIRequest

    /// Make an asynchronous request to the server for list of transit agencies
    ///
    ///  - parameters:
    ///    - request: An object that implements the `TransitAgenciesRequest` protocol, see `UTTransitAgenciesRequest` for concrete
    /// implementation that can be used, alternatively provide your own.
    ///    - completionHandler: Closure that is called when call has completed and response processed. Will either provide the
    /// data as an array of `TransitAgency` objects or an error, but never both.
    @warn_unused_result(message="Returned request object needed to cancel async operation")
    func sendRequest<R : TransitAgenciesRequest>(request:R, completionHandler:(data:R.Result?, error:ErrorType?) -> Void) -> UrbanThingsAPIRequest
    
    /// Make an asynchronous request to the server for a transit agency
    ///
    ///  - parameters:
    ///    - request: An object that implements the `TransitTripsRequest` protocol, see `UTTransitTripsRequest` for concrete
    /// implementation that can be used, alternatively provide your own.
    ///    - completionHandler: Closure that is called when call has completed and response processed. Will either provide the
    /// data as a `TransitDetailedRouteInfo` object or an error, but never both.
    @warn_unused_result(message="Returned request object needed to cancel async operation")
    func sendRequest<R : TransitTripsRequest>(request:R, completionHandler:(data:R.Result?, error:ErrorType?) -> Void) -> UrbanThingsAPIRequest
    
    /// Make an asynchronous request to the server for list of scheduled stop calls
    ///
    ///  - parameters:
    ///    - request: An object that implements the `TransitStopCallsRequest` protocol, see `UTTransitStopCallsRequest` for concrete
    /// implementation that can be used, alternatively provide your own.
    ///    - completionHandler: Closure that is called when call has completed and response processed. Will either provide the
    /// data as a `TransitStopScheduledCalls` object or an error, but never both.
    @warn_unused_result(message="Returned request object needed to cancel async operation")
    func sendRequest<R : TransitStopCallsRequest>(request:R, completionHandler:(data:R.Result?, error:ErrorType?) -> Void) -> UrbanThingsAPIRequest
    
    /// Make an asynchronous request to the server for trips grouped by calendar
    ///
    ///  - parameters:
    ///    - request: An object that implements the `TransitTripGroupsRequest` protocol, see `UTTransitTripGroupsRequest` for concrete
    /// implementation that can be used, alternatively provide your own.
    ///    - completionHandler: Closure that is called when call has completed and response processed. Will either provide the
    /// data as a `TransitTripCalendarGroup` object or an error, but never both.
    @warn_unused_result(message="Returned request object needed to cancel async operation")
    func sendRequest<R : TransitTripGroupsRequest>(request:R, completionHandler:(data:R.Result?, error:ErrorType?) -> Void) -> UrbanThingsAPIRequest
    
    /// Make an asynchronous request to the server for a realtime report.
    ///
    ///  - parameters:
    ///    - request: An object that implements the `RealtimeReportRequest` protocol, see `UTRealtimeReportRequest` for concrete
    /// implementation that can be used, alternatively provide your own.
    ///    - completionHandler: Closure that is called when call has completed and response processed. Will either provide the data as `TransitStopRTIResponse` object or an error, but never both.
    ///  - returns: `UrbanThingsAPIRequest` instance which can be used to cancel the asynchronous request.
    @warn_unused_result(message="Returned request object needed to cancel async operation")
    func sendRequest<R : RealtimeReportRequest>(request:R, completionHandler:(data:R.Result?, error:ErrorType?) -> Void) -> UrbanThingsAPIRequest

    /// Make an asynchronous request to the server for realtime stopboard information.
    ///
    ///  - parameters:
    ///    - request: An object that implements the `RealtimeStopboardRequest` protocol, see `UTRealtimeStopboardRequest` for concrete
    /// implementation that can be used, alternatively provide your own.
    ///    - completionHandler: Closure that is called when call has completed and response processed. Will either provide the data as `StopBoardResponse` object or an error, but never both.
    ///  - returns: `UrbanThingsAPIRequest` instance which can be used to cancel the asynchronous request.
    @warn_unused_result(message="Returned request object needed to cancel async operation")
    func sendRequest<R : RealtimeStopboardRequest>(request:R, completionHandler:(data:R.Result?, error:ErrorType?) -> Void) -> UrbanThingsAPIRequest
    
    /// Make an asynchronous request to the server for realtime resource status information.
    ///
    ///  - parameters:
    ///    - request: An object that implements the `RealtimeResourceStatusRequest` protocol, see `UTRealtimeResourceStatusRequest` for concrete
    ///    - completionHandler: Closure that is called when call has completed and response processed. Will either provide the data as a `ResourceStatus` object or an error, but never both.
    ///  - returns: `UrbanThingsAPIRequest` instance which can be used to cancel the asynchronous request.
    @warn_unused_result(message="Returned request object needed to cancel async operation")
    func sendRequest<R : RealtimeResourceStatusRequest>(request:R, completionHandler:(data:R.Result?, error:ErrorType?) -> Void) -> UrbanThingsAPIRequest

    /// Make an asynchronous request to the server for realtime resource status information.
    ///
    ///  - parameters:
    ///    - request: An object that implements the `RealtimeResourcesStatusRequest` protocol, see `UTRealtimeResourceStatusRequest` for concrete
    ///    - result: Closure that is called when call has completed and response processed. Will either provide the data as an array of `ResourceStatus` objects or an error, but never both.
    ///  - returns: `UrbanThingsAPIRequest` instance which can be used to cancel the asynchronous request.
    @warn_unused_result(message="Returned request object needed to cancel async operation")
    func sendRequest<R : RealtimeResourcesStatusRequest>(request:R, completionHandler:(data:R.Result?, error:ErrorType?) -> Void) -> UrbanThingsAPIRequest
    
    /// Make an asynchronous request to the server for directions.
    ///
    ///  - parameters:
    ///    - request: An object that implements the `DirectionsRequest` protocol, see `UTDirectionsRequest` for concrete
    /// implementation that can be used, alternatively provide your own.
    ///    - completionHandler: Closure that is called when call has completed and response processed. Will either provide the data as an array of `ResourceStatus` objects or an error, but never both.
    ///  - returns: `UrbanThingsAPIRequest` instance which can be used to cancel the asynchronous request.
    @warn_unused_result(message="Returned request object needed to cancel async operation")
    func sendRequest<R : DirectionsRequest>(request:R, completionHandler:(data:R.Result?, error:ErrorType?) -> Void) -> UrbanThingsAPIRequest
}