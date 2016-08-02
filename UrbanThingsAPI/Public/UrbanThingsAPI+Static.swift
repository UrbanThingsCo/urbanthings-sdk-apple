//
//  UrbanThingsAPI+Public.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 26/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

extension UrbanThingsAPI {

    /// Make an asynchronous request to the server for a list of import sources.
    ///
    ///  - parameters:
    ///    - request: Object that implements the `ImportSourceRequest` protocol, see `UTImportSourceRequest` for concrete
    /// implementation that can be used, alternatively provide your own.
    ///    - completionHandler: Closure that is called when call has completed and response processed. Will either provide the
    /// data as an array of `ImportSource` objects or an error, but never both.
    @warn_unused_result(message="Returned request object needed to cancel async operation")
    public func sendRequest<R: ImportSourcesRequest>(request: R, completionHandler:(data: R.Result?, error: ErrorType?) -> Void) -> UrbanThingsAPIRequest {
        return self.makeRequest("static/importsources",
                                request: request,
                                parameters:QueryParameters(),
                                completionHandler:completionHandler)
    }

    /// Make an asynchronous request to the server for a list of transport stops
    ///
    ///  - parameters:
    ///    - request: An object that implements the `TransitStopRequest` protocol, see `UTTransitStopRequest` for concrete
    /// implementation that can be used, alternatively provide your own.
    ///    - completionHandler: Closure that is called when call has completed and response processed. Will either provide the
    /// data as an array of `TransitStop` objects or an error, but never both.
    @warn_unused_result(message="Returned request object needed to cancel async operation")
    public func sendRequest<R: TransitStopsRequest>(request: R, completionHandler:(data: R.Result?, error: ErrorType?) -> Void) -> UrbanThingsAPIRequest {
        return self.makeRequest("static/transitstops",
                                request: request,
                                parameters:request.queryParameters,
                                completionHandler:completionHandler)
    }

    /// Make an asynchronous request to the server for a list of place points
    ///
    ///  - parameters:
    ///    - request: An object that implements the `PlacePointsRequest` protocol, see `UTPlacePointsRequest` for concrete
    /// implementation that can be used, alternatively provide your own.
    ///    - completionHandler: Closure that is called when call has completed and response processed. Will either provide the
    /// data as a `PlacePointList` object or an error, but never both.
    @warn_unused_result(message="Returned request object needed to cancel async operation")
    public func sendRequest<R: PlacePointsRequest>(request: R, completionHandler:(data: R.Result?, error: ErrorType?) -> Void) -> UrbanThingsAPIRequest {
        return self.makeRequest("static/placepoints",
                                request: request,
                                parameters:request.queryParameters,
                                completionHandler:completionHandler)
    }

    /// Make an asynchronous request to the server for a list of places
    ///
    ///  - parameters:
    ///    - request: An object that implements the `PlacesListRequest` protocol, see `UTPlacesListRequest` for concrete
    /// implementation that can be used, alternatively provide your own.
    ///    - completionHandler: Closure that is called when call has completed and response processed. Will either provide the
    /// data as a `PlacePointList` object or an error, but never both.
    @warn_unused_result(message="Returned request object needed to cancel async operation")
    public func sendRequest<R: PlacesListRequest>(request: R, completionHandler:(data: R.Result?, error: ErrorType?) -> Void) -> UrbanThingsAPIRequest {
        return self.makeRequest("static/places/List",
                                request: request,
                                parameters:request.queryParameters,
                                completionHandler:completionHandler)
    }

    /// Make an asynchronous request to the server for a list of transit routes for a given transit line name.
    ///
    ///  - parameters:
    ///    - request: An object that implements the `TransitRoutesByLineNameRequest` protocol, see `UTTransitRoutesByLineNameRequest` for concrete
    /// implementation that can be used, alternatively provide your own.
    ///    - completionHandler: Closure that is called when call has completed and response processed. Will either provide the
    /// data as a `TransitDetailedRouteInfo` object or an error, but never both.
    @warn_unused_result(message="Returned request object needed to cancel async operation")
    public func sendRequest<R: TransitRoutesByLineNameRequest>(request: R, completionHandler:(data: R.Result?, error: ErrorType?) -> Void) -> UrbanThingsAPIRequest {
        return self.makeRequest("static/routes/info/LineName",
                                request: request,
                                parameters:request.queryParameters,
                                completionHandler:completionHandler)
    }

    /// Make an asynchronous request to the server for a list of transit routes for a given source
    ///
    ///  - parameters:
    ///    - request: An object that implements the `TransitRouteSourceRequest` protocol, see `UTTransitRouteSourceRequest` for concrete
    /// implementation that can be used, alternatively provide your own.
    ///    - completionHandler: Closure that is called when call has completed and response processed. Will either provide the
    /// data as a `TransitDetailedRouteInfo` object or an error, but never both.
    @warn_unused_result(message="Returned request object needed to cancel async operation")
    public func sendRequest<R: TransitRoutesByImportSourceRequest>(request: R, completionHandler:(data: R.Result?, error: ErrorType?) -> Void) -> UrbanThingsAPIRequest {
        return self.makeRequest("static/routes/info/Source",
                                request: request,
                                parameters:request.queryParameters,
                                completionHandler:completionHandler)
    }

    /// Make an asynchronous request to the server for a list of transit routes calling at a specific transit stop
    ///
    ///  - parameters:
    ///    - request: An object that implements the `TransitRoutesByStopRequest` protocol, see `UTTransitRoutesByStopRequest` for concrete
    /// implementation that can be used, alternatively provide your own.
    ///    - completionHandler: Closure that is called when call has completed and response processed. Will either provide the
    /// data as a `TransitDetailedRouteInfo` object or an error, but never both.
    @warn_unused_result(message="Returned request object needed to cancel async operation")
    public func sendRequest<R: TransitRoutesByStopRequest>(request: R, completionHandler:(data: R.Result?, error: ErrorType?) -> Void) -> UrbanThingsAPIRequest {
        return self.makeRequest("static/routes/info/CallingAtStop",
                                request: request,
                                parameters:request.queryParameters,
                                completionHandler:completionHandler)
    }

    /// Make an asynchronous request to the server for a transit agency
    ///
    ///  - parameters:
    ///    - request: An object that implements the `TransitAgencyRequest` protocol, see `UTTransitAgencyRequest` for concrete
    /// implementation that can be used, alternatively provide your own.
    ///    - completionHandler: Closure that is called when call has completed and response processed. Will either provide the
    /// data as a `TransitAgency` object or an error, but never both.
    @warn_unused_result(message="Returned request object needed to cancel async operation")
    public func sendRequest<R: TransitAgencyRequest>(request: R, completionHandler:(data: R.Result?, error: ErrorType?) -> Void) -> UrbanThingsAPIRequest {
        return self.makeRequest("static/agencies",
                                request: request,
                                parameters:request.queryParameters,
                                completionHandler:completionHandler)
    }

    /// Make an asynchronous request to the server for list of transit agencies
    ///
    ///  - parameters:
    ///    - request: An object that implements the `TransitAgenciesRequest` protocol, see `UTTransitAgenciesRequest` for concrete
    /// implementation that can be used, alternatively provide your own.
    ///    - completionHandler: Closure that is called when call has completed and response processed. Will either provide the
    /// data as an array of `TransitAgency` objects or an error, but never both.
    @warn_unused_result(message="Returned request object needed to cancel async operation")
    public func sendRequest<R: TransitAgenciesRequest>(request: R, completionHandler:(data: R.Result?, error: ErrorType?) -> Void) -> UrbanThingsAPIRequest {
        return self.makeRequest("static/agencies",
                                request: request,
                                parameters:request.queryParameters,
                                completionHandler:completionHandler)
    }

    /// Make an asynchronous request to the server for a list of transit trips
    ///
    ///  - parameters:
    ///    - request: An object that implements the `TransitTripsRequest` protocol, see `UTTransitTripsRequest` for concrete
    /// implementation that can be used, alternatively provide your own.
    ///    - completionHandler: Closure that is called when call has completed and response processed. Will either provide the
    /// data as an array of `TransitTrip` object or an error, but never both.
    @warn_unused_result(message="Returned request object needed to cancel async operation")
    public func sendRequest<R: TransitTripsRequest>(request: R, completionHandler:(data: R.Result?, error: ErrorType?) -> Void) -> UrbanThingsAPIRequest {
        return self.makeRequest("static/trips",
                                request: request,
                                parameters:request.queryParameters,
                                completionHandler:completionHandler)
    }

    /// Make an asynchronous request to the server for list of scheduled stop calls
    ///
    ///  - parameters:
    ///    - request: An object that implements the `TransitStopCallsRequest` protocol, see `UTTransitStopCallsRequest` for concrete
    /// implementation that can be used, alternatively provide your own.
    ///    - completionHandler: Closure that is called when call has completed and response processed. Will either provide the
    /// data as a `TransitStopScheduledCalls` object or an error, but never both.
    @warn_unused_result(message="Returned request object needed to cancel async operation")
    public func sendRequest<R: TransitStopCallsRequest>(request: R, completionHandler:(data: R.Result?, error: ErrorType?) -> Void) -> UrbanThingsAPIRequest {
        return self.makeRequest("static/stopcalls",
                                request: request,
                                parameters: request.queryParameters,
                                completionHandler: completionHandler)
    }

    /// Make an asynchronous request to the server for trips grouped by calendar
    ///
    ///  - parameters:
    ///    - request: An object that implements the `TransitTripGroupsRequest` protocol, see `UTTransitTripGroupsRequest` for concrete
    /// implementation that can be used, alternatively provide your own.
    ///    - completionHandler: Closure that is called when call has completed and response processed. Will either provide the
    /// data as a `TransitTripCalendarGroup` object or an error, but never both.
    @warn_unused_result(message="Returned request object needed to cancel async operation")
    public func sendRequest<R: TransitTripGroupsRequest>(request: R, completionHandler:(data: R.Result?, error: ErrorType?) -> Void) -> UrbanThingsAPIRequest {
        return self.makeRequest("static/tripgroups/bycalendar",
                                request: request,
                                parameters: request.queryParameters,
                                completionHandler: completionHandler)
    }

    /// Make an asynchronous request to the server for trips grouped by calendar
    ///
    ///  - parameters:
    ///    - request: An object that implements the `TransitTripGroupsRequest` protocol, see `UTTransitTripGroupsRequest` for concrete
    /// implementation that can be used, alternatively provide your own.
    ///    - completionHandler: Closure that is called when call has completed and response processed. Will either provide the
    /// data as a `TransitTripCalendarGroup` object or an error, but never both.
    @warn_unused_result(message="Returned request object needed to cancel async operation")
    public func sendRequest<R: AppSearchRequest>(request: R, completionHandler:(data: R.Result?, error: ErrorType?) -> Void) -> UrbanThingsAPIRequest {
        return self.makeRequest("appSearch",
                                request: request,
                                parameters: request.queryParameters,
                                completionHandler: completionHandler)
    }

}
