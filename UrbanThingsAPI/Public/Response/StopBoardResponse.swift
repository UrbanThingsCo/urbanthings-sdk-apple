//
//  StopBoardResponse.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 26/04/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation

/// `StopBoardResponse` provides high level details for a stop board reques, extends `RTIResponse`.
public protocol StopBoardResponse : RTIResponse {
    /// The time at which this data was generated. 
    var timestamp:NSDate? { get }
    /// One or more StopBoard objects that make up the main data contained within this `StopBoardResponse`.
    var stopBoards:[StopBoard]? { get }
}