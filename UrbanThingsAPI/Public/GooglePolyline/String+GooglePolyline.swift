//
//  String+GooglePolyline.swift
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

#if !os(watchOS)
    import MapKit
#else
    import CoreLocation
#endif

extension String {
    
    fileprivate struct CoordinateEncoder {
        
        private struct PointEncoder {
            
            private var previousValue:Int = 0
            
            mutating func encode(coordinate:CLLocationDegrees) -> String {
                
                let intCoord = Int(round(coordinate * 1E5))
                let delta = intCoord - self.previousValue
                self.previousValue = intCoord
                var value = delta << 1;
                if delta < 0 {
                    value = ~value
                }
                
                var encoded = ""
                var hasNext = true
                while(hasNext) {
                    let next = value >> 5
                    var encValue = UInt8(value & 0x1f)
                    hasNext = next > 0
                    if hasNext {
                        encValue = encValue | 0x20
                    }
                    encoded.append(Character(UnicodeScalar(encValue + 0x3f)))
                    value = next
                }
                
                return encoded
            }
        }
        
        private var latitudeEncoder = PointEncoder()
        private var longitudeEncoder = PointEncoder()
        
        mutating func encode(coordinate:CLLocationCoordinate2D) -> String {
            return latitudeEncoder.encode(coordinate: coordinate.latitude) + longitudeEncoder.encode(coordinate: coordinate.longitude)
        }
    }
    
    private struct PolylineIterator : IteratorProtocol {
        
        typealias Element = CLLocationCoordinate2D
        
        struct Coordinate {
            private var value:Double = 0.0
            mutating func nextValue(polyline:String.UnicodeScalarView, index:inout String.UnicodeScalarView.Index) -> Double? {
                
                if index >= polyline.endIndex {
                    return nil
                }
                
                var byte:Int
                var res:Int = 0
                var shift:Int = 0
                
                repeat {
                    byte = Int(polyline[index].value) - 63;
                    if !(0..<64 ~= byte) {
                        return nil
                    }
                    res |= (byte & 0x1F) << shift;
                    shift += 5;
                    index = polyline.index(after: index)
                } while (byte >= 0x20 && index < polyline.endIndex);
                
                self.value = self.value + Double(((res % 2) == 1) ? ~(res >> 1) : res >> 1);
                
                return self.value * 1E-5
            }
        }
        
        private var polylineUnicodeChars:String.UnicodeScalarView
        private var current:String.UnicodeScalarView.Index
        private var latitude:Coordinate = Coordinate()
        private var longitude:Coordinate = Coordinate()
        
        init(_ polyline:String) {
            self.polylineUnicodeChars = polyline.unicodeScalars
            self.current = self.polylineUnicodeChars.startIndex
        }
        
        mutating func next() -> Element? {
            guard let lat = latitude.nextValue(polyline: self.polylineUnicodeChars, index: &self.current), let lng = longitude.nextValue(polyline: self.polylineUnicodeChars, index: &self.current) else {
                return nil
            }
            return Element(latitude: lat, longitude: lng)
        }
    }
    
    private struct PolylineSequence : Sequence {

        typealias Iterator = PolylineIterator
        
        private let encodedPolyline:String
        
        init(_ encodedPolyline:String) throws {
            var index = encodedPolyline.startIndex
            try encodedPolyline.unicodeScalars.forEach {
                if !(63..<127 ~= $0.value) {
                    throw GooglePolylineError.InvalidPolylineString(string: encodedPolyline, errorPosition: index)
                }
                index = encodedPolyline.index(after: index)
            }
            
            self.encodedPolyline = encodedPolyline
        }
        
        func makeIterator() -> PolylineIterator {
            return PolylineIterator(self.encodedPolyline)
        }
    }
    
    /**
     Initialize string to Google encoded polyline for a sequence of Core Location
     points.
     
     - parameter sequence: Sequence of points to encode
     
     - returns: Initialized encoded string
     */
    public init<S:Sequence>(googlePolylineLocationCoordinateSequence sequence:S) where S.Iterator.Element == CLLocationCoordinate2D {
        var encoder = CoordinateEncoder()
        self.init(sequence.reduce("") {
            $0 + encoder.encode(coordinate: $1)
        })!
    }
    
    /**
     Returns sequence of CLLocationCoordinate2D points for the decoded Google polyline
     string.
     
     - throws: GooglePolylineError.InvalidPolylineString if string is not valid polyline
     
     - returns: Sequence of coordinates
     */
    public func asCoordinateSequence() throws -> AnySequence<CLLocationCoordinate2D> {
        return AnySequence<CLLocationCoordinate2D>(try PolylineSequence(self))
    }

    /**
     Returns array of CLLocationCoordinate2D points for the decoded Google polyline
     string.
     
     - throws: GooglePolylineError.InvalidPolylineString if string is not valid polyline
     
     - returns: Array of coordinates
     */
    public func asCoordinateArray() throws -> [CLLocationCoordinate2D] {
        return [CLLocationCoordinate2D](try self.asCoordinateSequence())
    }

}

// MapKit is not available for watchOS

#if !os(watchOS)

extension String {
    
    /**
     Initialize string to Google encoded polyline for a sequence of MKMapPoint
     points.
     
     - parameter sequence: Sequence of points to encode
     
     - returns: Initialized encoded string
     */
    @available(tvOS 9.2, *)
    public init<S:Sequence>(googlePolylineMapPointSequence sequence:S) where S.Iterator.Element == MKMapPoint {
        self.init(googlePolylineLocationCoordinateSequence:sequence.map { MKCoordinateForMapPoint($0) })
    }
    
    /**
     Initialize string to Google encoded polyline from points contained in an instance
     of MKMultiPoint.
     
     - parameter sequence: Sequence of points to encode
     
     - returns: Initialized encoded string
     */
    @available(tvOS 9.2, *)
    public init(googlePolylineMKMultiPoint polyline:MKMultiPoint) {
        
        var encoder = CoordinateEncoder()
        
        var count = polyline.pointCount
        var ptr = polyline.points()
        
        var s = ""
        while(count > 0) {
            let coord = MKCoordinateForMapPoint(ptr.pointee)
            s = s + encoder.encode(coordinate: coord)
            ptr = ptr.successor()
            count -= 1
        }
        
        self.init(s)!
    }
    
    /**
     Returns MKPolyline instance containing points from decoded Google polyline
     string.
     
     - throws: GooglePolylineError.InvalidPolylineString if string is not valid polyline
     
     - returns: MKPolyline instance
     */
    @available(tvOS 9.2, *)
    public func asMKPolyline() throws -> MKPolyline {
        return MKPolyline(sequence:try self.asCoordinateSequence())
    }
}

#endif
