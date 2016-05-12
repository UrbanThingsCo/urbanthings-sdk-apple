//
//  StopBoardColor.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 26/04/2016.
//  Copyright © 2016 Fat Attitude. All rights reserved.
//

/// `StopBoardColor` details a color pair for background and text. Inherited by `StopBoard`, `StopBoardGroup` and `StopBoardMessage`.
public protocol StopBoardColor {
    /// The color that represents this StopBoard - this may be used to add branding-specific colors to stops that relate to 
    /// public transportation lines with a published brand colour. For example, London Underground lines have distinct branding 
    /// colors per-line in the United Kingdom.
    var color:UTColor? { get }
    /// The color of text that can be legibly displayed against backgrounds of the color contained within the `color` field.
    var colorCompliment:UTColor? { get }
}