//
//  UrbanThingsAPI+Public.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 02/05/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

import Foundation

private let APIKeyHTTPHeaderKey = "X-Api-Key"
private let AcceptHTTPHeaderKey = "Accept"
private let AcceptLanguageHTTPHeaderKey = "Accept-Language"
private let ApplicationJSON = "application/json"

/// Protocol for object defining the endpoint and version to be used by the API
public protocol Service {
    /// Provides the endpoint base url, for example `https://api.urbanthings.co/`
    var endpoint:String { get }
    /// Details the version of the API to use at the endpoint, for example `2.0`
    var version:String { get }
}


/// Protocol defining object that will be given opportunity to provide a modified version of each request before being passed
/// on to the request phase if provided to an `UrbanThingsAPI` instance.
public protocol RequestModifier {
    ///  - parameters:
    ///    - request: NSURLRequest instance configured ready to be issued as request to endpoint.
    ///    - logger: The Logger instance in use by the API instance, provided for any logging requirements.
    ///  - returns: The request that should be issued, either passing though the passed in instance or 
    /// returning a alternative instance altered as needed. A mutable copy of the passed instance can be 
    /// obtained by `request.mutableCopy()`.
    func getRequest(request:NSURLRequest, logger:Logger) -> NSURLRequest
}

/// Protocol defining the request handler used within the API implementation. Custom implementation can be provided
/// to an `UrbanThingsAPI` instance to alter behaviour. If no alternative implementation is provided a default implementation
/// will automatically be provided.
public protocol RequestHandler {
    /// Make an asynchronous request to the service endpoint. Alternative implementations can be provided to the API if
    /// alternative behaviour is required, such as using background session. Also provide to allow testing of components that
    /// use the results of the API without needing to make actual network requests. For this an implementation can be provided
    /// that provided appropriate 'canned' data responses to requests.
    /// 
    ///  - parameters:
    ///    - request: `NSURLRequest` to be made
    ///    - logger: The Logger instance in use by the API instance, provided for any logging requirements.
    ///    - completion: Closure to be called with results of request
    ///  - returns: `UrbanThingsAPIRequest` instance that can be used to cancel the asynchronous operation
    func makeRequest(request:NSURLRequest, logger:Logger, completion:(NSData?, NSURLResponse?, ErrorType?) -> Void) -> UrbanThingsAPIRequest
}

struct UTRequestHandler : RequestHandler {
    
    let session:NSURLSession
    
    init(session:NSURLSession) {
        self.session = session
    }
    
    func makeRequest(request:NSURLRequest, logger:Logger, completion:(NSData?, NSURLResponse?, ErrorType?) -> Void) -> UrbanThingsAPIRequest {
        let task = self.session.dataTaskWithRequest(request, completionHandler: completion)
        task.resume()
        return task
    }
}

private let Endpoint = "https://bristol.api.urbanthings.io/api"
private let CurrentVersion = "2.0"

struct UTDefaultService : Service {
    let endpoint = Endpoint
    let version = CurrentVersion
}

public extension NSURLSessionConfiguration {
    /// Creates an `NSURLSessionConfiguration` instance setup with an api key. This has been provided
    /// for uses who want to provide their own customised session to pass into the `UrbanThingsAPI` 
    /// instance. The session configuration returned can be further modified and then passed into
    /// the `UrbanThingsAPI` instance `init` method.
    ///
    ///  - parameters:
    ///    - apiKey: String containing the users API key assigned by UrbanThings for API access.
    public class func sessionConfigurationForUrbanThingsAPI(apiKey apiKey:String) -> NSURLSessionConfiguration {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        var headers:[NSObject:AnyObject] = configuration.HTTPAdditionalHeaders ?? [:]
        // Set the API key into default request header
        headers[APIKeyHTTPHeaderKey] = apiKey
        // Indicate that JSON results wanted
        headers[AcceptHTTPHeaderKey] = ApplicationJSON
        // If supplied configuration doesn't have accept languages add based on device locale
        if headers[AcceptLanguageHTTPHeaderKey] == nil {
            headers[AcceptLanguageHTTPHeaderKey] = NSLocale.httpAcceptLanguage
        }
        configuration.HTTPAdditionalHeaders = headers
        return configuration
    }
}

/// The main API object. Create an instance to access the UrbanThings API server. The object supports customization
/// through the injection of user provided implementations of the service endpoint, a request modifier, a request handler
/// and a logger. Additionally individual requests can provide custom response parsers.
///
/// However for basic use all that is needed is a valid UrbanThings API key.
///
/// ````
/// let api = UrbanThingsAPI(apiKey:"A valid API key")
/// ````
public final class UrbanThingsAPI : UrbanThingsAPIType {
    
    let urlSession:NSURLSession
    let requestHandler:RequestHandler
    let requestModifier:RequestModifier?
    let service:Service
    let logger:Logger
    
    /// Initialize an instance of the UrbanThingsAPI.
    ///
    ///  - parameters:
    ///    - apiKey: String containing the users API key assigned by UrbanThings for API access.
    ///    - service: Instance of Service protocol detailing service end point to be called by the API. If nil or omitted the
    /// default instance will connect to the standard service end point.
    ///    - requestModifier: Optional implementation of ResponseModifier protocol. If provided the instance will be given
    /// sight of, and the oppurtity to modify, every network request made by the API instance.
    ///    - logger: Optional instance implementing the Logger protocol. Any messages that the API logs will be presented to
    /// this instance for logging purposes. If omitted the default logger will write all messages to the console using the 
    /// NSLog function.
    public convenience init(apiKey:String, service:Service? = nil, requestModifier:RequestModifier? = nil, logger:Logger? = nil) {
        let session = NSURLSession(configuration: NSURLSessionConfiguration.sessionConfigurationForUrbanThingsAPI(apiKey: apiKey))
        self.init(session:session, service:service, requestHandler:nil, requestModifier:requestModifier, logger:logger)
    }

    /// Initialize an instance of the UrbanThingsAPI.
    ///
    ///  - parameters:
    ///    - session: An NSURLSession object that will be used for network requests made by the API instance. The session should
    /// have been configured by an NSURLSessionConfiguration instance obtained through 
    /// `NSURLSessionConfiguration.sessionConfigurationForUrbanThingsAPI(apiKey:)` extension method.
    /// `sessionConfigurationForUrbanThingsAPI` class function and modified as needed to ensure correct function of the API instance.
    ///    - service: Instance of Service protocol detailing service end point to be called by the API. If nil or omitted the
    /// default instance will connect to the standard service end point.
    ///    - requestHandler: Optioanl implementation of the RequestHandler protocol. If provided will be passed each NSURLRequest
    /// and is responsible for issuing the request and passing back the response. The instance should have a reference to the
    /// NSURLSession that is passed in to the API instance as it most likely will need this to make network requests. Alternatively
    /// an instance could be provided that generates canned responses without using the network for testing purposes.
    ///    - requestModifier: Optional implementation of ResponseModifier protocol. If provided the instance will be given
    /// sight of, and the oppurtity to modify, every network request made by the API instance.
    ///    - logger: Optional instance implementing the Logger protocol. Any messages that the API logs will be presented to
    /// this instance for logging purposes. If omitted the default logger will write all messages to the console using the
    /// NSLog function.
    public init(session:NSURLSession, service:Service? = nil, requestHandler:RequestHandler? = nil, requestModifier:RequestModifier? = nil, logger:Logger? = nil) {
        
        self.urlSession = session
        self.requestModifier = requestModifier
        self.requestHandler = requestHandler ?? UTRequestHandler(session: session)
        self.service = service ?? UTDefaultService()
        self.logger = logger ?? UTLogger()
    }
}
