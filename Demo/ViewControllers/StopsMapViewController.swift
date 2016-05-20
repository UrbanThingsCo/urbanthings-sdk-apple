//
//  StopsMapViewController.swift
//  UrbanThingsAPI
//
//  Created by Mark Woollard on 06/05/2016.
//  Copyright © 2016 UrbanThings. All rights reserved.
//

import UIKit
import UTAPI
import MapKit

private let MarkerReuseIdentifier = "MarkerReuseIdentifier"

/// Adapter to make a TransitStop usabled as a map MKAnnotation
class TransitStopAdapter : NSObject, MKAnnotation {
    
    let stop:UTAPI.TransitStop
    
    init(stop:UTAPI.TransitStop) {
        self.stop = stop
    }
    
    @objc var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.stop.location.latitude, longitude: self.stop.location.longitude)
    }
    
    @objc var title:String? {
        return self.stop.name
    }
    
    @objc var subtitle:String? = "Fetching..."
}

class StopsMapViewController : UIViewController, MKMapViewDelegate {
    
    var dataObserver:AnyObject?
    var locationObserver:AnyObject?
    var selectionObserver:AnyObject?

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataObserver = NSNotificationCenter.defaultCenter().addObserver(StopDataUpdated, object: nil, queue: nil) { [weak self] _ in
            let markers = StopsModel.sharedInstance.data.map { TransitStopAdapter(stop: $0) }
            NSOperationQueue.mainQueue().addOperationWithBlock {
                self?.updateMap(markers)
            }
        }
        self.locationObserver = NSNotificationCenter.defaultCenter().addObserver(LocationChanged, object: nil, queue: NSOperationQueue.mainQueue()) { [weak self] _ in
            self?.updateLocation(StopsModel.sharedInstance.location!)
        }
        self.selectionObserver = NSNotificationCenter.defaultCenter().addObserver(TransitStopSelected, object: nil, queue: NSOperationQueue.mainQueue()) { [weak self] note in
            if note.object !== self {
                if let annotation = self?.mapView.annotations.filter({ ($0 as? TransitStopAdapter)?.stop.primaryCode == (note.userInfo?[TransitStopPrimaryCode] as? String) }).first {
                    self?.mapView.selectAnnotation(annotation, animated: true)
                }
            }
        }
        
        NSOperationQueue.mainQueue().addOperationWithBlock {
            self.updateLocation(StopsModel.sharedInstance.location!)
        }
    }
    
    func updateMap(markers:[TransitStopAdapter]) {
        self.mapView.removeAnnotations(self.mapView.annotations)
        self.mapView.addAnnotations(markers)
    }
    
    func updateLocation(location:Location) {
        let coord = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        let camera = MKMapCamera(lookingAtCenterCoordinate: coord, fromDistance: 5000, pitch: 0, heading: 0)
        self.mapView.setCamera(camera, animated: true)
    }
    
    var resourceRequest:UrbanThingsAPIRequest?
    
    // MARK: MKMapViewDelegate
    @objc func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        if let annotation = view.annotation as? TransitStopAdapter {
            NSNotificationCenter.defaultCenter().postNotificationName(TransitStopSelected,
                                                                      object: self,
                                                                      userInfo: [TransitStopPrimaryCode:annotation.stop.primaryCode])
            
            self.resourceRequest?.cancel()
            self.resourceRequest = StopsModel.sharedInstance.getStopResources(annotation.stop) { msg in
                NSOperationQueue.mainQueue().addOperationWithBlock {
                    (view.annotation as? TransitStopAdapter)?.subtitle = msg
                }
                self.resourceRequest = nil
            }
        }
    }
    
    @objc func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let view = mapView.dequeueReusableAnnotationViewWithIdentifier(MarkerReuseIdentifier) as? MKPinAnnotationView ?? MKPinAnnotationView(annotation: annotation, reuseIdentifier: MarkerReuseIdentifier)
        view.annotation = annotation
        view.canShowCallout = true
        if (annotation as? TransitStopAdapter)?.stop.placePointType == PlacePointType.CycleHireDock {
            view.pinTintColor = UIColor.redColor()
        } else {
            view.pinTintColor = UIColor.orangeColor()
        }
        return view
    }
    
    @objc func mapView(mapView: MKMapView, didDeselectAnnotationView view: MKAnnotationView) {
        resourceRequest?.cancel()
        resourceRequest = nil
    }
}