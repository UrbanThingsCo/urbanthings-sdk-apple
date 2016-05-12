//
//  APIResponseType.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 26/04/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

import Foundation

protocol APIResponseType {
    associatedtype DataType
    
    var success:Bool { get }
    var localizedErrorMessage:String? { get }
    var data:DataType? { get }
}
