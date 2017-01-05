//
//  Request.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 08/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

/// Request defines the protocol all requests must implement. All supported requests are
/// extensions of this protocol.
public protocol Request {

    /// The type of Result expected in response to the request
    associatedtype Result

    /// Endpoint for request, this will be appended to the base url. An example
    /// endpoint would be 'static/importsources'.
    var endpoint: String { get }

    /// Parser to use when processing response to the request
    var parser:(_ json: Any?, _ logger: Logger) throws -> Result { get }

    /**
     Parameters to add to url request
    */
    var queryParameters: QueryParameters { get }
}

public protocol GetRequest: Request {

}

public protocol PostRequest: Request {

    var contentType: String { get }
    func getBody() throws -> Data
}
