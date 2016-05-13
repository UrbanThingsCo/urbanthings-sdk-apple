//
//  String+Extensions.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 26/04/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

import Foundation

extension String {

    /**
     Encode the string as a url parameter value
     
     - returns: encoded string
     */
    public func stringByURLEncodingAsQueryParameterValue() -> String {
        return self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryParameterValueAllowedCharacterSet())!
    }
}

