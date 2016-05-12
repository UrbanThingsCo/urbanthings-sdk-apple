//
//  MKPolyline+GooglePolyline.swift
//  SwiftGooglePolyline
//
//  The MIT License (MIT)
//
//  Copyright (c) 2016 Mark Woollard
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import MapKit

@available(tvOS 9.2, *)
public extension MKPolyline {
    /// Initializes an MKPolyline instance from a Google polyline string.
    ///
    ///  - parameters:
    ///    - googlePolyline: String containing the polyline data encoded as Google
    /// polyline. See https://developers.google.com/maps/documentation/utilities/polylinealgorithm
    /// full details.
    ///  - throws: GooglePolylineError.InvalidPolylineString
    public convenience init(googlePolyline:String) throws {
        self.init(sequence:try googlePolyline.asCoordinateSequence())
    }
    
    /// Initializes an MKPolyline instance from a sequence of CLLocationCoordinate2D instances
    ///
    ///  - parameters:
    ///    - sequence: SequenceType providing CLLocationCoordinate2D instances
    public convenience init<S:SequenceType where S.Generator.Element == CLLocationCoordinate2D>(sequence:S) {
        let array = Array<CLLocationCoordinate2D>(sequence)
        self.init(coordinates: UnsafeMutablePointer(array), count: array.count)
    }
}

@available(tvOS 9.2, *)
public extension MKMultiPoint {
    /// Returns a Google polyline string for the set of points contained in the
    /// instance.
    public var googlePolyline:String {
        get {
            return String(googlePolylineMKMultiPoint: self)
        }
    }
}