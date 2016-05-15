//
//  UrbanThingsAPI.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 26/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

extension NSLocale {
    static var httpAcceptLanguage:String {
        return preferredLanguages().prefix(5).enumerate().map { "\($0.1);q=\(1.0-Double($0.0)*0.1)" }.joinWithSeparator(", ")
    }
}

extension NSURLSessionTask : UrbanThingsAPIRequest {
    
}

extension Service {
    var baseURLString:String {
        return "\(endpoint)/\(version)"
    }
}

extension UrbanThingsAPI {
    
    func toHttpResponse(response:NSURLResponse?) throws -> NSHTTPURLResponse {
        guard let httpResponse = response as? NSHTTPURLResponse else {
            throw Error(unexpected: "Expected NSHTTPURLResponse, got \(response)", file: #file, function: #function, line: #line)
        }
        return httpResponse
    }
    
    func validateHTTPStatus(response:NSHTTPURLResponse, data:NSData?) throws {
        guard response.statusCode < 300 else {
            var message:String?
            if response.hasJSONBody && data != nil {
                // This is to catch the non-standard JSON based error that API currently reports at times. If this is
                // not present message is default localised message for error code
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: [])
                    message = (json as? [String:AnyObject])?["message"] as? String
                } catch {
                }
            }
            throw Error.HTTPStatusError(code: response.statusCode, message: message)
        }
    }
    
    func validateData(response:NSHTTPURLResponse, data:NSData?) throws {
        guard response.hasJSONBody else {
            throw Error(unexpected: "Content-Type not application/json", file: #file, function: #function, line: #line)
        }
        
        guard let _ = data else {
            throw Error(unexpected: "No data in response", file: #file, function: #function, line: #line)
        }
    }
    
    func parseData<T>(parser:(json:AnyObject?, logger:Logger) throws -> T, data:NSData) throws -> T {
        #if DEBUG
        if let utf8 = String(data: data, encoding: NSUTF8StringEncoding) {
            logger.log(.Debug, utf8)
        }
        #endif
        let json = try NSJSONSerialization.JSONObjectWithData(data, options: [])
        let apiResponse:APIResponse<T> = try APIResponse<T>(json:json, parser:parser, logger:self.logger)
        guard apiResponse.success else {
            throw Error.APIError(message: apiResponse.localizedErrorMessage)
        }
        return apiResponse.data!
    }

    func handleResponse<T>(parser:(json:AnyObject?, logger:Logger) throws -> T, result:(data:T?, error:ErrorType?)->Void)
        -> (data:NSData?, response:NSURLResponse?, error:ErrorType?) -> Void {
            
            func taskCompletionHandler(data:NSData?, response:NSURLResponse?, error:ErrorType?) {
                guard error == nil else {
                    result(data:nil, error:error)
                    return
                }
                
                do {
                    let httpResponse = try self.toHttpResponse(response)
                    logger.log(.Debug, "\(httpResponse)")
                    try self.validateHTTPStatus(httpResponse, data: data)
                    try self.validateData(httpResponse, data: data)
                    result(data:try self.parseData(parser, data: data!) as T, error:nil)
                } catch {
                    self.logger.log(.Error, "\(error)")
                    result(data:nil, error:error as ErrorType)
                }
            }
            
            return taskCompletionHandler
    }

    func makeRequest<R : Request>(call:String, request:R, parameters:QueryParameters = QueryParameters(), completionHandler:(data:R.Result?, error:ErrorType?)->Void) -> UrbanThingsAPIRequest {
        let requestStr = "\(self.service.baseURLString)/\(call)\(parameters.description)"
        let urlRequest = NSURLRequest(URL:NSURL(string:requestStr)!)
        let modifiedRequest = self.requestModifier?.getRequest(urlRequest, logger:logger) ?? urlRequest
        return self.requestHandler.makeRequest(modifiedRequest, logger:logger, completion: handleResponse(request.parser, result: completionHandler))
    }
    
    func makePostRequest<R : Request>(call:String, request:R, body:NSData? = nil, completionHandler:(data:R.Result?, error:ErrorType?)->Void) -> UrbanThingsAPIRequest {
        
        let requestStr = "\(self.service.baseURLString)/\(call)"
        let urlRequest = NSMutableURLRequest(URL:NSURL(string:requestStr)!)
        urlRequest.HTTPMethod = "POST"
        urlRequest.HTTPBody = body
        urlRequest.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

        let modifiedRequest = self.requestModifier?.getRequest(urlRequest, logger:logger) ?? urlRequest
        
        return self.requestHandler.makeRequest(modifiedRequest, logger:logger, completion: handleResponse(request.parser, result: completionHandler))
    }

}

