//
//  StopBoardRow.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 15/05/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

import Foundation
import UrbanThingsAPI

/// `StopBoardRow` provides details of a row on a stop board.
@objc public protocol StopBoardRow {
    /// An additional, longer-form piece of text that provides further information about this vehicle.
    var noteText:String? { get }
    /// A boolean indicating whether the information provided about this vehicle is based on Real Time Information.
    var isRTI:Bool { get }
    /// This field identifies the StopBoardRow as belong to one of the `StopBoardGrouping` instances described in
    /// the parent `StopBoard` object. Depending upon the data source, rows might be grouped according to criteria
    /// such as published line name or destination. A client might wish to look up the `StopBoardGrouping` using this ID
    /// in order to perform tasks such as group-based display or filtering.
    var groupID:String? { get }
    /// Type of vehicle that the row relates to.
    var vehicleMode:TransitMode { get }
    /// The publicly displayed identifying information for this vehicle - for example a license plate, or vehicle number, if available.
    var vehicleRegistrationText:String? { get }
    /// A persistent ID that a client can use as a hint for visual display of changing vehicle times - this ID, if available, can
    /// persist between refreshes of the stop board.
    var trackingID:String? { get }
    /// A label identifying the vehicle. For buses, this might be a Line name, for trains this might be a published time.
    /// The meaning of this label may be clarified via the `idHeader` property of the parent `StopBoard` object.
    var idLabel:String? { get }
    /// A label providing secondary identification information for the vehicle. This is often a destination or terminating stop.
    /// The meaning of this label may be clarified via the `mainHeader` property of the parent `StopBoard` instance.
    var mainLabel:String? { get }
    /// A label providing additional identification information for the vehicle if available. The meaning of this label may be
    /// clarified via the `secondaryHeader` property of the parent StopBoard instance.
    var secondaryLabel:String? { get }
    /// A label identifying the platform at which this vehicle will stop, if applicable.
    var platformLabel:String? { get }
    /// The first of two labels identifying the time at which the vehicle will stop. For example, `timeMajorLabel` might contain
    /// the value '12', while `timeMinorLabel` might contain the value 'minutes'.
    var timeMajorLabel:String? { get }
    /// The second of two labels identifying the time at which the vehicle will stop For example, `timeMajorLabel` might contain
    /// the value '12', while `timeMinorLabel` might contain the value 'minutes'.
    var timeMinorLabel:String? { get }
    
}