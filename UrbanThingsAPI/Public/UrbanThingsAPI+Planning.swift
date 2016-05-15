//
//  UrbanThingsAPI+Planning.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 04/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

class EmptyRequest : UrbanThingsAPIRequest {
    func cancel() {}
}

extension UrbanThingsAPI {
    
    /// Make an asynchronous request to the server for realtime resource status information.
    ///
    ///  - parameters:
    ///    - request: An object that implements the `DirectionsRequest` protocol, see `UTDirectionsRequest` for concrete
    ///    - result: Closure that is called when call has completed and response processed. Will either provide the data as an array of `ResourceStatus` objects or an error, but never both.
    ///  - returns: `UrbanThingsAPIRequest` instance which can be used to cancel the asynchronous request.
    @warn_unused_result(message="Returned request object needed to cancel async operation")
    public func sendRequest<R : DirectionsRequest>(request:R, completionHandler:(data:R.Result?, error:ErrorType?) -> Void) -> UrbanThingsAPIRequest {
        do {
            let body = try request.toJSON()
            return self.makePostRequest("plan/directions",
                                        request: request,
                                        body: body,
                                        completionHandler: completionHandler)
        } catch {
            completionHandler(data: nil, error: error as ErrorType)
        }
        
        return EmptyRequest()
    }
}