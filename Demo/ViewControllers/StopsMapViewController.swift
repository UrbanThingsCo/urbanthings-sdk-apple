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
        
        self.dataObserver = NotificationCenter.default.addObserver(name: StopDataUpdated, object: nil, queue: nil) { [weak self] _ in
            let markers = StopsModel.sharedInstance.data.map { TransitStopAdapter(stop: $0) }
            OperationQueue.main.addOperation {
                self?.updateMap(markers: markers)
            }
        }
        self.locationObserver = NotificationCenter.default.addObserver(name: LocationChanged, object: nil, queue: OperationQueue.main) { [weak self] _ in
            self?.updateLocation(location: StopsModel.sharedInstance.location!)
        }
        self.selectionObserver = NotificationCenter.default.addObserver(name: TransitStopSelected, object: nil, queue: OperationQueue.main) { [weak self] note in
            if (note.object as AnyObject) !== self {
                if let annotation = self?.mapView.annotations.filter({ ($0 as? TransitStopAdapter)?.stop.primaryCode == (note.userInfo?[TransitStopPrimaryCode] as? String) }).first {
                    self?.mapView.selectAnnotation(annotation, animated: true)
                }
            }
        }
        
        OperationQueue.main.addOperation {
            self.updateLocation(location: StopsModel.sharedInstance.location!)
        }
    }
    
    func updateMap(markers:[TransitStopAdapter]) {
        self.mapView.removeAnnotations(self.mapView.annotations)
        self.mapView.addAnnotations(markers)
    }
    
    func updateLocation(location:Location) {
        let coord = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        let camera = MKMapCamera(lookingAtCenter: coord,
                                 fromDistance: 5000,
                                 pitch: 0,
                                 heading: 0)
        self.mapView.setCamera(camera, animated: true)
    }
    
    var resourceRequest:UrbanThingsAPIRequest?
    
    // MARK: MKMapViewDelegate
    @objc func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation as? TransitStopAdapter {
            NotificationCenter.default.post(name: Notification.Name(TransitStopSelected),
                                                                      object: self,
                                                                      userInfo: [TransitStopPrimaryCode:annotation.stop.primaryCode])
            
            self.resourceRequest?.cancel()
            self.resourceRequest = StopsModel.sharedInstance.getStopResources(stop: annotation.stop) { msg in
                OperationQueue.main.addOperation {
                    (view.annotation as? TransitStopAdapter)?.subtitle = msg
                }
                self.resourceRequest = nil
            }
        }
    }
    
    @objc func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let view = mapView.dequeueReusableAnnotationView(withIdentifier: MarkerReuseIdentifier) as? MKPinAnnotationView ?? MKPinAnnotationView(annotation: annotation, reuseIdentifier: MarkerReuseIdentifier)
        view.annotation = annotation
        view.canShowCallout = true
        if (annotation as? TransitStopAdapter)?.stop.placePointType == PlacePointType.CycleHireDock {
            view.pinTintColor = UIColor.red
        } else {
            view.pinTintColor = UIColor.orange
        }
        return view
    }
    
    @objc func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        resourceRequest?.cancel()
        resourceRequest = nil
    }
}
