//
//  AddPinViewController.swift
//  Pinpoint
//
//  Created by Harjap Uppal on 11/28/17.
//  Copyright © 2017 Harjap Uppal. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import os.log

class AddPinViewController: UIViewController,CLLocationManagerDelegate, MKMapViewDelegate {
    var icon = Icons()
    var pin: Pin?
    @IBOutlet weak var map: MKMapView!
    var coordinate: CLLocationCoordinate2D!
    var locationManager:CLLocationManager!
    
    @IBOutlet weak var save: UIButton!
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIButton, button === save else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        pin = Pin(location: coordinate)

    }
    
    @IBOutlet var gesture: UITapGestureRecognizer!
    
    //allow user to add pin
    @IBAction func action(_ sender: UITapGestureRecognizer) {
        let touchPoint = sender.location(in: map)
        let newCoordinates = map.convert(touchPoint, toCoordinateFrom: map)
        let annotation = MKPointAnnotation()
        annotation.coordinate = newCoordinates
        annotation.title = "Pin"
        self.map.removeAnnotations(map.annotations)
        self.map.addAnnotation(annotation)
        coordinate = annotation.coordinate
    }
  

        override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
            map.addGestureRecognizer(gesture)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        determineCurrentLocation()
    }
    
    func determineCurrentLocation()
    {
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            //locationManager.startUpdatingHeading()
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        print("Updating location")
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        map.setRegion(region, animated: true)
        
        // Drop a pin at user's Current Location
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
        myAnnotation.title = "Current location"
        self.map.addAnnotation(myAnnotation)
        coordinate = myAnnotation.coordinate
        manager.stopUpdatingLocation()

    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    
    func map(map: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?
    {
        if !(annotation is MKPointAnnotation) {
            return nil
        }
        
        let annotationIdentifier = "AnnotationIdentifier"
        var annotationView = map.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView!.canShowCallout = true
        }
        else {
            annotationView!.annotation = annotation
        }
        
        let pinImage = icon.smallCar
        annotationView!.image = pinImage
        return annotationView
    }
}


