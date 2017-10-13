
//
//  UrbanThingsAPI.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 26/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

extension NSLocale {
    static var httpAcceptLanguage: String {
        return preferredLanguages.prefix(5).enumerated().map { "\($0.1);q=\(1.0-Double($0.0)*0.1)" }.joined(separator: ", ")
    }
}

extension URLSessionTask : UrbanThingsAPIRequest {

}

extension Service {
    var baseURLString: String {
        return "\(endpoint)/\(version)"
    }
}

extension UrbanThingsAPI {

    func toHttpResponse(response: URLResponse?) throws -> HTTPURLResponse {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw UTAPIError(unexpected: "Expected HTTPURLResponse, got \(String(describing: response))", file: #file, function: #function, line: #line)
        }
        return httpResponse
    }

    func validateHTTPStatus(response: HTTPURLResponse, data: Data?) throws {
        guard response.statusCode < 300 else {
            var message: String? = "Unknown server error"
            if response.hasJSONBody && data != nil {
                // This is to catch the non-standard JSON based error that API currently reports at times. If this is
                // not present message is default localised message for error code
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    message = (json as? [String:AnyObject])?["message"] as? String
                } catch {
                }
            }
            throw UTAPIError.HTTPStatusError(code: response.statusCode, message: message)
        }
    }

    func validateData(response: HTTPURLResponse, data: Data?) throws {
        guard response.hasJSONBody else {
            throw UTAPIError(unexpected: "Content-Type not application/json", file: #file, function: #function, line: #line)
        }

        guard let _ = data else {
            throw UTAPIError(unexpected: "No data in response", file: #file, function: #function, line: #line)
        }
    }

    func parseData<T>(parser:(_ json: Any?, _ logger: Logger) throws -> T, data: Data) throws -> T {
        #if DEBUG
        if let utf8 = String(data: data, encoding: String.Encoding.utf8) {
            logger.log(level: .debug, utf8)
            print("\(utf8)")
        }
        #endif
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
        var v2or3: Any? = json?["data"]
        if v2or3 == nil {
            v2or3 = json
        }
        return try parser(v2or3, logger)
    }

    func handleResponse<T>(parser:@escaping (_ json: Any?, _ logger: Logger) throws -> T, result:@escaping (_ data: T?, _ error: Error?) -> Void)
        -> (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void {

            func taskCompletionHandler(data: Data?, response: URLResponse?, error: Error?) {
                guard error == nil else {
                    result(nil, error)
                    return
                }

                do {
                    let httpResponse = try self.toHttpResponse(response: response)
                    logger.log(level: .debug, "\(httpResponse)")
                    try self.validateHTTPStatus(response: httpResponse, data: data)
                    try self.validateData(response: httpResponse, data: data)
                    result(try self.parseData(parser: parser, data: data!) as T, nil)
                } catch {
                    self.logger.log(level: .error, "\(error)")
                    result(nil, error as Error)
                }
            }

            return taskCompletionHandler
    }

    func buildURL<R: Request>(request: R) -> String {
        let parameters = request.queryParameters.description
        let separator = parameters.characters.count > 0 ? "&" : "?"
        return "\(self.service.baseURLString)/\(request.endpoint)\(request.queryParameters.description)\(separator)apikey=\(self.service.key)"
    }
}
