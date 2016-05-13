//
//  NSHTTPURLResponse+Logging.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 27/04/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

import Foundation

private let ContentTypeHTTPHeaderKey = "Content-Type"
private let ContentTypeJSON = "application/json"

extension NSHTTPURLResponse {
    
    var hasJSONBody:Bool {
        return self.allHeaderFields[ContentTypeHTTPHeaderKey]?.hasPrefix(ContentTypeJSON) ?? false
    }
}
