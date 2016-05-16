![Logo](http://urbanthings.co/wp-content/themes/urbanthings/assets/images/urbanthings_logo_small.png)

# UrbanThings API Framework for Apple Platforms
[![Carthage compatible](https://img.shields.io/badge/Version-0.9-109480.svg?style=flat)]()
[![CI Status](http://img.shields.io/travis/urbanthings/urbanthings-sdk-apple.svg?style=flat)](https://travis-ci.org/urbanthings/urbanthings-sdk-apple)

## Introduction

The UrbanThings API for Apple Platforms has been developed as a modern, highly configurable SDK that brings simplicity of use alongside type safety and testability.

The SDK has been developed in Swift and is to be used with Swift.  This is in order to make the resulting data fully type safe with no ambiguity as to the meaning of any data elements.  The resulting data can be [made available to Objective-C code if needed](#objective-c).

### Supported platforms
[![Platform](https://img.shields.io/badge/Platforms-iOS|tvOS|watchOS|OSX-109480.svg?style=flat)]()
[![Swift Version](https://img.shields.io/badge/Swift-2.2-109480.svg?style=flat)](https://developer.apple.com/swift)

The SDK is compatible with iOS (including extensions), OS X (incuding extensions), tvOS and watchKit. It is built with Xcode 7.3.1 / Swift 2.2. Deployment versions supported are as follows:

Platform | Min Supported Version
---------|----------------------
iOS|8.0
tvOS|9.0
watchKit|2.0
OS X|10.9

The SDK is a core component of the UrbanThings ecosystem and the same framework that UrbanThings uses within our own software for Apple products. 

The SDK has been [made available](http://www.github.com/urbanthings) to the Open Source community and we welcome feedback and pull requests for enhancements and fixes for any issues found. Feedback can be submitted via the GitHub issues tracker, emailed to [apisupport@urbanthings.io](mailto:apisupport@urbanthings.io). Or, for the truly impressive coder, if you fork the project, we'd love to see your Pull Requests.

## Adding the API to your project
We support a number of ways of including the framework in your project. 

#### Carthage
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-109480.svg?style=flat)](https://github.com/Carthage/Carthage)

To use the Carthage framework manager insure you have Carthage installed and add a **Cartfile** to your project ([see docs](https://github.com/Carthage/Carthage)). Add the following to your **Cartfile**:

```
github urbanthings/urbanthings-sdk-apple
```
(adjust as per Carthage docs if you want specific version or branch). Also refer to the [docs](https://github.com/Carthage/Carthage) for details on how to build and install or update the framework into your project.

#### Swift Package Manager
[![SPM compatible](https://img.shields.io/badge/SPM-compatible-109480.svg?style=flat)]()

If you use Swift Package Manager add UrbanThingsAPI as dependency to you Package.swift:

```
let package = Package(
  name: "MyPackage",
  dependencies: [
    .Package(url: "https://github.com/urbanthings/urbanthings-sdk-apple.git", "0.9")
  ]
)
```

#### CocoaPods
[![CocoaPods Compatible](https://img.shields.io/badge/CocoaPods-compatible-109480.svg?style=flat)](http://cocoapods.org)

The SDK is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "UrbanThingsAPI"
```
More information on CocoaPods can be found [here](https://cocoapods.org).

#### Add source to your project
If you do not want to use a package manager clone the [repository](https://github.com/urbanthings/urbanthings-sdk-apple.git), open the `UrbanThingsAPI.xcodeproj` project with Xcode and build the target(s) for the platforms you required. You can then add the frameworks to your project. Alternatively you can add the  `UrbanThingsAPI.xcodeproj` as a project within your own project.

## Obtaining an API instance
To request data from the server, you instantiate an instance of the `UrbanThingsAPI` class.

```
import UrbanThingsSDK

let api = UrbanThingsAPI("A valid API key")
```

A single instance can be safely used for all requests during the lifetime of an application, but you can create and destroy instances as you need and maintain multiple instances at the same time.

## Making a request
#### Basic Requests
Requests are made by calling `sendRequest` and passing it a `Request`.  Basic usage is as easy as passing in one of the `UT...Request` objects provided, all of which implement the required protocols.  For example:

```
api.sendRequest(UTImportSourcesRequest()) { data, error in
}
```

Data is [returned asynchronously](#responses) as part of the trailing closure ([see below](#responses)).

You can use such [pre-provided default implementations](#supported-requests) of all Requests, or advanced users may wish to [create their own](#custom-requests).

#### Passing in request data
Many API requests require the passing of input data to specify the required parameters.  For example, let's request the set of place points within a 500 metre radius of the UrbanThings office:

```
let myOffice = CLLocationCoordinate2D(latitude: 51.5291205, longitude:-0.0802295)
api.sendRequest(UTPlacePointsRequest(center:myOffice, radius:500)) { data, error in
}
```

For the above example, we've used `UTPlacePointsRequest`, the provided implementation of the `PlacePointsRequest` protocol. This has initializers to take the various permitted combinations of input; we've passed a `radius` of 500 and a `center` location corresponding to our office.

In this way, the SDK design prevents many invalid requests from being constructed and ensures all required information is being provided.  This is enforced via the compile-time requirements of these initializers.

<a name="responses"></a>
## Handing the response
The `sendRequest` method is asynchronous and a closure is provided when making the call to pass back the results of that call when available. The `completionHandler` closure receives optional arguments: `data` (populated if a request succeeds) and `error` (populated if a request fails).

The `data` argument is typed to the data expected from the response. The SDK defines a full set of protocols for all data objects returned by the API. Internally, the response JSON is parsed into implementations of these protocols which are then passed to the completion handler closure. This means in your code you are always working with the correctly typed objects and thus no mis-interpreation of the data can occur. This is all enforced at compile time.

Let's extend the example above to include some processing of the response:

```
api.sendRequest(UTPlacePointsRequest(center:office, radius:500)) { data, error in
	if let data = data {
		for placePoint in data.placePoints {
			print("\(placePoint.name)")
		}
	} else {
		print("Error - \(error)")
	}
}
```

In this case data is `PlacePointList?`, an optional for the protocol `PlacePointList`. We can iterate over the points contained within simply by accessing the properties defined by the protocol.

Let's examine an alternative request, for a list of import sources:

```
api.sendRequest(UTImportSourcesRequest()) { data, error in
	if let data = data {
		for importSource in data {
			print("\(importSource.importSourceID) - \(importSource.name)")
		}
	} else {
		print("Error - \(error)")
	}
```

Here the response data is typed as `[ImportSource]?`, an optional for an array containing instances of the `ImportSource` protocol. Again we can access this data through the protocol with full type safety.

Please see the [online documentation](http://portal-dev.api.urbanthings.io/ios_sdk_docs/Classes/UrbanThingsAPI.html) for details of the full set of protocols that may be received through the API.
## Advanced Usage

<a name="custom-requests"></a>
### Customising Requests
All requests are based on the `Request` protocol. Specific requests are protocols implementing `Request` as well as a protocol defining the particular request that is to be made. For example the `ImportSourceRequest` protocol defines a request that obtains a list of import sources. So to make a request you provide an implementation of the `ImportSourceRequest`. 

Whilst you can implement the various request protocols defined by the API SDK we don't expect you to do this so provide a full set of default implementations. All have the same name as the request protocol that they implement, but prefixed with `UT`.  For example, `ImportSourceRequest` has an SDK provided implementation `UTImportSourcesRequest`.


### Configuration
The entire API SDK is built around protocols allowing easy testing, customization and configuration. At the highest level the `UrbanThingsAPI` is an implementation of `UrbanThingsAPIType`.  This means that an alternative implementation of the entire API could be provided if desired for testing purposes.

When instantiating the provided implementation of the API a number of options for configuration are possible:

#### Logging
The API protocol `Logger` defines methods for logging instrumentation messages. By default if none is provided by the API client the standard logger is installed in the API instance. This will output messages to the console using the `NSLog` method. There are 4 levels of log message available and the most verbose, `Debug` will only be output when the SDK is build for debug. If you provide your own logger implementation you can handle logging however you see fit.

#### Request Modification
The API protocol `RequestModifier` defines a method that will be called for every request made by the SDK with the NSURLRequest instance that wil be used to make the request. This gives an opportunity to have sight of the request before its sent and if needed change or modify it. 

#### Session Configuration
The API makes requests using an instance of NSURLSession. By default this is configured automatically as needed for the API. However if there is a need to provide a different session configuration an alternative session instance can be provided. To aid in providing an alternative session the `NSURLSessionConfiguration` extension class method `sessionConfigurationForUrbanThingsAPI(apiKey:)`. This will return a NSURLSessionConfiguration instance configured for the given API key along with some other requirements for the API use. This may then be modified as needed and used to create an NSURLSession that can be passed to the `UrbanThingsAPI` init method. If a session is provided it will be used for all requests made by the API instance. 

````
let config = NSURLSessionConfiguration.sessionConfigurationForUrbanThingsAPI(apiKey:"A valid API Key")
// Modify config as needed
let session = NSURLSession(configuration:config)
let api = UrbanThingsAPI(session: session)
````

#### Request Handler
The API protocol `RequestHandler` defines a method to make an asychronous request and pass the results back through a completion handler when available. The default implementation used by the API instance makes requests through the NSURLSession instance as outlined above (either internally generated or passed in). If an alternative is provided other handling can be implemented. As an example for testing a version could be written that doesn't actually make network requests but returns canned data responses:

```
// Mock request cancellaton object that will be returned by the mock
// request handler.
public struct MockRequest : UrbanThingsAPIRequest {
    public func cancel() {}
}

// An implementation of RequestHandler to mock response to a request. The mock handler
// is initialized with a file of JSON to return for any requests made through it.
struct MockRequestHandler : RequestHandler {

    let data:NSData?
    
    init(jsonFile:String) {
        if let path = NSBundle(forClass: MockRequestHandler.self)
        		.pathForResource(jsonFile, ofType: "json") {
            data = NSData(contentsOfFile: path)
        } else {
            data = nil
        }
    }
    
    func makeRequest(request:NSURLRequest, 
                     logger:Logger, 
                     completion:(NSData?, NSURLResponse?, ErrorType?) -> Void) -> UrbanThingsAPIRequest {
        
        let response = NSHTTPURLResponse(URL: request.URL!, 
                                         statusCode: data != nil ? 200:404,
                                         HTTPVersion: "1.1", 
                                         headerFields: ["Content-Type" : "application/json"])
        completion(data, response, nil)
        return MockRequest()
    }
}

// Lets test response processing of a trips group request
func testTripGroupsRequest() {
        
    // Construct a mock request handler
    let requestHandler = try MockRequestHandler(jsonFile: "response.json")
    
    // Configure a session
    let config = NSURLSessionConfiguration.sessionConfigurationForUrbanThingsAPI(apiKey:"apikey")
    let session = NSURLSession(configuration: config)
    
    // Create an API instance injecting the mock request handler
    let api = UrbanThingsAPI(session: session, requestHandler: requestHandler)
    
    // Make a request (input data is ignored so anything can be passed for routeID)
    let _ = api.sendRequest(UTTransitTripGroupRequest(routeID:"abc")) { data, error in
    
        // Do validation of data / error based on the input JSON and expected result
    }
}

```

Note you can only provide a `RequestHandler` instance if you are also providing the NSURLSession instance as it is assumed that the provided request handler will need to know about the session and it has been left for the implementation of these to decide how that is done (or if it is actually needed at all).

#### Custom Parsing
As discussed above requests are passed to the API as instances of the `Request` protocol.  A default set of request implementations are provided but custom request implementations can be used if needed. As well as defining the values to be passed up with request it also defines the parser that will be used to process the JSON response from the server. If a custom request is provided it will need to provide a parser. The API framework provides a standard set of parser functions that can be used. These are all named `urbanThingsParser` but through use of generics the approrpiate parser will be used for the response. For example the ImportSourcesRequest returns `[ImportSource]`, an array of import source instances. The parser that returns `[ImportSource]` will be selected to parse JSON into `[ImportSource]`. 

If you do provide your own custom parsers, e.g. to return your own implementation of a response protocol, you don't have to use generics, just a function with the correct signature. 

#### Summary
The configuration options available allow for great flexibility and easy testability yet also simple use of the API too if these advanced features are not needed. We look forward to hearing your feedback on this approach.

<a name="supported-requests"></a>
## Supported requests
The full set of current request protocols defined alongside their provided implementations is as follows:

Protocol|Provided implementation|Purpose
--------|-----------------------|-------
DirectionsRequest|UTDirectionsRequest|Used to make a request for directions between two places. Request has many options for refining routing such as accessibility, transport mode etc.
ImportSourcesRequest|UTImportSourcesRequest|Used to request a list of import sources. This request has no additional input parameters.
PlacePointsRequest|UTPlacePointsRequest|Used to request a list of place points that fall within a geographical area. The arae can be defined as a circle or rectangle and futher options are available to refine the request.
PlacesListRequest|UTPlacesListRequest|Used to request list of places matching (containing) a search string.
RealtimeReportRequest|UTRealtimeReportRequest|Used to request a realtime arrivals and departure information suitable for data processing purposes.
RealtimeResourcesStatusRequest|UTRealtimeResourcesStatusRequest|Used to request the resource status of a single transit stop, for example a car park or hire cycle dock.
RealtimeResourceStatusRequest|UTRealtimeResourceStatusRequest|Used to request the resources status of a number of transit stops.
RealtimeStopboardRequest|UTRealtimeStopboardRequest|Used to request real time arrivals and departures information suitable for presentational purposes.
TransitAgenciesRequest|UTTransitAgenciesRequest|Used to request a list of transit agencies from a single import source.
TransitAgencyRequest|UTTransitAgencyRequest|Used to request a single transit agency.
TransitRoutesByImportSourceRequest|UTTransitRoutesByImportSourceRequest|Used to request the externally imported data sets avialable.
TransitRoutesByLineNameRequest|UTTransitRoutesByLineNameRequest|Used to request a search for bus/train/other modal routes that match certain parameters. For example, nearby bus routes matching a specified line name. The list can be further filtered by the agency operating the route(s) and/or the import source of the data.
TransitRoutesByStopRequest|UTTransitRoutesByStopRequest|Used to request a search for transit routes served by a particular stop.
TransitStopCallsRequest|UTTransitStopCallsRequest|Used to request a scheduled timetable for a specified TransitStop - i.e. a full list of vehicles scheduled to call at the stop on a specified date within a specified period of time.
TransitStopsRequest|UTTransitStopsRequest|Used to request matching TransitStop objects - bus stops, train stations, car parks, etc.
TransitTripGroupsRequest|TransitTripGroupsRequest|Used to request trips along a particular route, grouped by running day (i.e. a timetable)  or some other specified metric.
TransitTripsRequest|UTTransitTripsRequest|Used to request details for a specific trip, i.e. a particular journey along a known route. A single trip can be retrieved using its ID, or all trips along a particular route can be retrieved.

<a name="objective-c"></a>
## Objective C Support
As a design decision the protocols defined for the response data are deliberately not Objective-C compatible.

#### Why we took this decision
The protocols defined for the response data are deliberately not Objective-C compatible as doing so puts constraints on what type of properties can be defined. Specifically we wanted to enforce the use of optionals for fields that are optional and non-optionals for those that are always present. For values that 
are not NSObject subclasses this is not possible if Objective-C compatability is to be supported. `Enum` types, numerical values such as `Int`, `UInt`, `Double` and `Bool` are such cases. 

```
protocol SwiftOnly {
	var intOptional:Int?  { get }
	var uintOptional:Unt?  { get }
}

@objc protocol ObjcEquivalent {
	var intOptional: NSNumber?  { get }
	var uintOptional: NSNumber?  { get }
}
```

The Objective-C compatabile version no longer enfonces the correct numerical type since the NSNumber instances could contain any value. Its also not clear when using this structure which type of numerical value is expected to be contained within the NSNumber instances. 

```
let swift:SwiftOnly = ASwiftVersion()
let objc:ObjcEquivalent = AnObjCVersion()

if let n = swift.intOptional {
	// n is of type Int
}

if let nsNumber = objc.intOptional {
	// How shoud we use nsNumber?
	let n = nsNumber.integerValue
	let f = nsNumber.floatValue
	let b = nsNumber.boolValue
}

// The following are all valid as well and will
// provide n, b and f as their respective types.
if let n = objc.intOptional as? Int {
}
if let b = objc.intOptional as? Bool {
}
if let f = objc.intOptional as? Float {
}
```

Because of the above ambiguity when working in Swift we have taken the decision not to provide Objective-C compatability directly.

#### How to work in Objective-C
To use data within Objective-C it needs to be converted to Objective-C compatabile classes. Whilst you are free to implement this yourself to meet your needs we are providing a separate framework within the SDK **UTAPIObjCAdapter**.

The framework provides a full set of objects that can adapt the pure Swift response data structures to be useable from Objective-C. These all take an object implementing the corresponding Swift response protocol and implement a corresponding Objective-C protocol. Again this protocol based approach allows you to provide your own implementations of the Objective-C data response protocols if you don't want to use the provided implementations.

As an example lets assume we have an Objective-C class that processes a list of `PlacePoint` objects:

```
import <UTAPIObjCAdapter/UTAPIObjCAdapter.h>

@interface PlacePointProcessor : NSObject
- (void)process:(NSArray<PlacePoint *> * _Nonnull)points;
@end

@implementation PlacePointProcessor
- (void)process:(NSArray<PlacePoint *> * _Nonnull)points {
    // Do some processing...
}
@end
```

Objective-C code snippet above assumes that the necessary bridging headers and Xcode options are configured. Please see the relevant [Apple documentation](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/BuildingCocoaApps/) for more details.

Now we can write some Swift code to request the data to be processed by the Objective-C code:

```
import UrbanThingsAPI
import UTAPIObjCAdapter

let api = UrbanThingsAPI(apiKey:"A VALID API KEY")
let processor = PlacePointProcessor()
api.sendRequest(UTPlacePointsRequest(center:office, radius:500)) { data, error in
	if let data = data {
		// Map the array of Swift objects to adapted Objective-C objects
		let adaptedData = data.points.map { UTPlacePoint(adapt:$0) }
		// Can now pass this to the Objective-C method
		processor.process(adaptedData)
	} else {
		print("Error - \(error)")
	}
}
```

#### _ObjectiveCBridgeable protocol
Items that are bridgable between Swift and Objective-C implement this protocol. However at this time this protocol is poorly documented. We will be looking into whether this is an approach to simplify interoperabilty as well although there are some complications within the framework as how we might acheive this cleanly. However if we can work through the issues you would then have a set of Objective-C objects / adapters and could convert using type casting:

```
// Get objc is instance of ObjcAdapter for ASwiftVersion instance
let objc: ObjcAdapter =  ASwiftVersion()
// Similar for arrys
let objcArray:[ObjcAdapter] = swiftArray
```

Watch this space for more on Swift / Objective-C interoperability and don't hesitate to [contribute to the discussion](mailto:apisupport@urbanthings.io)

#### What if I don't want Swift?
We will continue to offer the [legacy Objective-C API](http://www.github.com/urbanthings) for those users who do not wish to use any Swift code in their projects.

## Bonus Material
We have included a Google polyline parser which will convert a Google polyline string into a sequence of `CLLocationCoordinate2D` instances or build an `MKPolyline` from the string. 

```
// A valid polyline
let polyline = "_p~iF~ps|U_ulLnnqC_mqNvxq`@"

// Iterate over sequence of CLLocationCoordinate2D values
for point in try polyline.asCoordinateSequence() {
	print("lat=\(point.latitude), lng=\(point.longitude)")
}

// Get a MKPolyline instance
let mkPolyline = try polyline.asMKPolyline()

```

## License
The UrbanThings API Framework for Apple Platforms is made available under the [Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0). Please see the [LICENSE](file:LICENSE) file for further details.
