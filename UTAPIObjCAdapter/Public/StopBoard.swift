//
//  StopBoard.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 15/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import Foundation
import UTAPI

@objc public protocol StopBoard : Attribution, StopBoardColor {
    /// A piece of text that describes the StopBoard, unique to a particular StopBoardResponse.
    /// In cases where the StopBoardResponse contains only a single StopBoard, this may be `nil` or set to the value 'STOPBOARD'
    var headerLabel:String? { get }
    /// The StopBoardRow objects that make up this StopBoard, each corresponding to a vehicle that will call at this stop.
    var rows:[StopBoardRow] { get }
    /// A list of StopBoardGroup objects, each with a unique ID. Each StopBoardRow object may be identified with one of these
    /// groups by means of its GroupID field.
    var groups:[StopBoardGroup] { get }
    /// A list of service/disruption messages that relate to this particular StopBoard.
    var messages:[StopBoardMessage] { get }
    /// If this is set to `true`, no `StopBoardRow` instances (as contained in the rows property) contain a `SecondaryLabel` string.
    var hideSecondary:TriState { get }
    /// If this is set to `true`, no `StopBoardRow` instances (as contained in the Rows property) contain a `PlatformLabel` string.
    var hidePlatform:TriState { get }
    /// If this is set to `false`, a client should consider that each group of `StopBoardRow` instances represents a distinct dataset.
    /// For example, one group might represent 'Arrivals' and another group might represent 'Departures'.
    var enableGroupFiltering:TriState { get }
    /// A string that describes the purpose of the IDLabel string contained in each StopBoardRow Clients may wish
    /// to display this string as a 'column header' in a presented stop board.
    var idHeader:String? { get }
    /// A string that describes the purpose of the MainLabel string contained in each `StopBoardRow`. Clients may wish to display this
    /// string as a 'column header' in a presented stop board.
    var mainHeader:String? { get }
    /// A string that describes the purpose of the secondaryLabel string contained in each `StopBoardRow`. Clients may wish to display
    /// this string as a 'column header' in a presented stop board.
    var secondaryHeader:String? { get }
    ///  A string that describes the purpose of the platformLabel string contained in each `StopBoardRow`. Clients may wish to display
    /// this string as a 'column header' in a presented stop board.
    var platformHeader:String? { get }
    /// A string that describes the purpose of the TimeLabel string contained in each `StopBoardRow`. Clients may wish to display this
    /// string as a 'column header' in a presented stop board.
    var timeHeader:String? { get }
    /// A string that indicates the reason why no data has been returned in this StopBoard. In cases where `StopBoardRow` instancces
    /// exist, this will be `nil`.
    var noDataLabel:String? { get }
}

@objc public class UTStopBoard : UTAttribution, StopBoard {
    
    var stopBoard: UTAPI.StopBoard { return self.adapted as! UTAPI.StopBoard }
    
    public init(adapt: UTAPI.StopBoard) {
        self.rows = adapt.rows.map { UTStopBoardRow(adapt: $0) }
        self.groups = adapt.groups.map { UTStopBoardGroup(adapt: $0) }
        self.messages = adapt.messages.map { UTStopBoardMessage(adapt: $0) }
        self.hideSecondary = TriState(adapt.hideSecondary)
        self.hidePlatform = TriState(adapt.hidePlatform)
        self.enableGroupFiltering = TriState(adapt.enableGroupFiltering)
        super.init(adapt: adapt)
    }
    
    public var headerLabel:String? { return self.stopBoard.headerLabel }
    public let rows:[StopBoardRow]
    public let groups:[StopBoardGroup]
    public let messages:[StopBoardMessage]
    public let hideSecondary:TriState
    public let hidePlatform:TriState
    public let enableGroupFiltering:TriState
    public var idHeader:String? { return self.stopBoard.idHeader }
    public var mainHeader:String? { return self.stopBoard.mainHeader }
    public var secondaryHeader:String? { return self.stopBoard.secondaryHeader }
    public var platformHeader:String? { return self.stopBoard.platformHeader }
    public var timeHeader:String? { return self.stopBoard.timeHeader }
    public var noDataLabel:String? { return self.stopBoard.noDataLabel }
    public var color:UTColor? { return self.stopBoard.color }
    public var colorCompliment:UTColor? { return self.stopBoard.colorCompliment }
}
