//
//  APIResponseType.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 26/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

protocol APIResponseType {
    associatedtype DataType

    var data: DataType? { get }
}
