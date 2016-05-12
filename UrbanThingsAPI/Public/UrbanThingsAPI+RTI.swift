//
//  UrbanThingsAPI+RTI.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 02/05/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

import Foundation

extension UrbanThingsAPI {
    
    /// Make an asynchronous request to the server for a realtime report.
    ///
    ///  - parameters:
    ///    - parameters: An object that implements the `RealtimeReportRequest` protocol, see `UTRealtimeReportRequest` for concrete
    /// implementation that can be used, alternatively provide your own.
    ///    - result: Closure that is called when call has completed and response processed. Will either provide the data as `TransitStopRTIResponse` object or an error, but never both.
    ///  - returns: `UrbanThingsAPIRequest` instance which can be used to cancel the asynchronous request.
    @warn_unused_result(message="Returned request object needed to cancel async operation")
    public func sendRequest<R : RealtimeReportRequest>(request:R, completionHandler:(data:R.Result?, error:ErrorType?) -> Void) -> UrbanThingsAPIRequest {
        return self.makeRequest("rti/report",
                                request: request,
                                parameters:request.queryParameters,
                                completionHandler:completionHandler)
    }

    /// Make an asynchronous request to the server for realtime stopboard information.
    ///
    ///  - parameters:
    ///    - request: An object that implements the `RealtimeStopboardRequest` protocol, see `UTRealtimeStopboardRequest` for concrete
    /// implementation that can be used, alternatively provide your own.
    ///    - result: Closure that is called when call has completed and response processed. Will either provide the data as `StopBoardResponse` object or an error, but never both.
    ///  - returns: `UrbanThingsAPIRequest` instance which can be used to cancel the asynchronous request.
    @warn_unused_result(message="Returned request object needed to cancel async operation")
    public func sendRequest<R : RealtimeStopboardRequest>(request:R, completionHandler:(data:R.Result?, error:ErrorType?) -> Void) -> UrbanThingsAPIRequest {
        return self.makeRequest("rti/stopboard",
                                request: request,
                                parameters:request.queryParameters,
                                completionHandler:completionHandler)
    }

    /// Make an asynchronous request to the server for realtime resource status information.
    ///
    ///  - parameters:
    ///    - request: An object that implements the `RealtimeResourceStatusRequest` protocol, see `UTRealtimeResourceStatusRequest` for concrete
    ///    - result: Closure that is called when call has completed and response processed. Will either provide the data as an `ResourceStatus` object or an error, but never both.
    ///  - returns: `UrbanThingsAPIRequest` instance which can be used to cancel the asynchronous request.
    @warn_unused_result(message="Returned request object needed to cancel async operation")
    public func sendRequest<R : RealtimeResourceStatusRequest>(request:R, completionHandler:(data:R.Result?, error:ErrorType?) -> Void) -> UrbanThingsAPIRequest {
        return self.makeRequest("rti/resources/status",
                                request: request,
                                parameters:request.queryParameters,
                                completionHandler:completionHandler)
    }
    
    /// Make an asynchronous request to the server for realtime resource status information.
    ///
    ///  - parameters:
    ///    - request: An object that implements the `RealtimeResourcesStatusRequest` protocol, see `UTRealtimeResourceStatusRequest` for concrete
    ///    - result: Closure that is called when call has completed and response processed. Will either provide the data as an array of `ResourceStatus` objects or an error, but never both.
    ///  - returns: `UrbanThingsAPIRequest` instance which can be used to cancel the asynchronous request.
    @warn_unused_result(message="Returned request object needed to cancel async operation")
    public func sendRequest<R : RealtimeResourcesStatusRequest>(request:R, completionHandler:(data:R.Result?, error:ErrorType?) -> Void) -> UrbanThingsAPIRequest {
        return self.makeRequest("rti/resources/status",
                                request: request,
                                parameters:request.queryParameters,
                                completionHandler:completionHandler)
    }
}