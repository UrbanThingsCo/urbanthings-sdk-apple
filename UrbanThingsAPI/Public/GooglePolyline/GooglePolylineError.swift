//
//  GooglePolylineError.swift
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

import Foundation

/// ErrorType enum for errors that occur whilst parsing a Google polyline into
/// set of coordinate points.
public enum GooglePolylineError: Error {
    /// The string was not a valid Google polyline. Error includes the source string and index position of failure within that string.
    case InvalidPolylineString(string:String, errorPosition:String.Index)
}

extension GooglePolylineError : CustomStringConvertible {
    
    /// Implementation of `CustomStringCovertible` protocol.
    public var description:String {
        get {
            switch self {
            case .InvalidPolylineString(let string, let errorPosition):
                let offset = string.characters.distance(from: string.startIndex, to: errorPosition)
                let char = string.characters[string.characters.index(string.characters.startIndex, offsetBy:offset)]
                return "Invalid Google Polyline \"\(string)\". '\(char)' at position \(offset)"
            }
        }
    }
}
