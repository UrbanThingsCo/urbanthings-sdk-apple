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

    func sendRequest<R: GetRequest>(request: R, completionHandler: @escaping (R.Result?, Error?) -> Void) -> UrbanThingsAPIRequest

    func sendRequest<R: PostRequest>(request: R, completionHandler: @escaping (R.Result?, Error?) -> Void) -> UrbanThingsAPIRequest

}
