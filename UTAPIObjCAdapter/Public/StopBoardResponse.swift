//
//  StopBoardResponse.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 20/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation
import UTAPI

/// `StopBoardResponse` provides high level details for a stop board reques, extends `RTIResponse`.
@objc public protocol StopBoardResponse : RTIResponse {
    /// The time at which this data was generated.
    var timestamp:Date? { get }
    /// One or more StopBoard objects that make up the main data contained within this `StopBoardResponse`.
    var stopBoards:[StopBoard]? { get }
}

@objc public class UTStopBoardResponse : UTRTIResponse, StopBoardResponse {

    var stopBoardResponse:UTAPI.StopBoardResponse { return self.adapted as! UTAPI.StopBoardResponse }

    public init(adapt:UTAPI.StopBoardResponse) {
        self.stopBoards = adapt.stopBoards?.map { UTStopBoard(adapt: $0) }
        super.init(adapt: adapt)
    }

    public var timestamp:Date? { return self.stopBoardResponse.timestamp }
    public let stopBoards:[StopBoard]?
}
