//
//  ImportSourcesRequest.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 08/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

/// Defines an request of import sources.
public protocol ImportSourcesRequest: GetRequest {

    associatedtype Result = [ImportSource]

    /// Parser to be used to process the response to the request.
    var parser: (_ json: Any?, _ logger: Logger) throws -> Result { get }
}

/// Default implementation of `ImportSourcesRequest` protocol provided by the API as standard means
/// of passing parameters to API request methods. You may provide your own implementation if needed to pass to the API
/// request methods.
public struct UTImportSourcesRequest: ImportSourcesRequest {

    public typealias Result = [ImportSource]
    public typealias Parser = (_ json: Any?, _ logger: Logger) throws -> Result
    public let endpoint = "static/importsources"
    public let queryParameters: QueryParameters = [:]

    /// Parser to be used to process the response to the request.
    public let parser: Parser

    /// Initialize an instance of `UTImportSourcesRequest`
    ///
    ///  - parameters:
    ///    - parser: If a custom parser should be used to process the response provide here. Otherwise the default
    /// parser will be used.
    public init(parser: @escaping Parser = urbanThingsParser) {
        self.parser = parser
    }
}
