//
//  ViewController.swift
//  Pinpoint
//
//  Created by Harjap Uppal on 11/23/17.
//  Copyright © 2017 Harjap Uppal. All rights reserved.
//

import UIKit
import ARCL
import CoreLocation
import MapKit
class ViewController: UIViewController {
    //let icons = Icons();
    @IBOutlet weak var dist: UILabel!
    @IBOutlet weak var map: MKMapView!
    var locationManager:CLLocationManager!
    public var pin: Pin!
    let sceneLocationView = SceneLocationView()
    var updateDistTimer: Timer?
    var pinLocation:CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(sceneLocationView)
        sceneLocationView.run()
        
        if pin != nil {
            
            //set up pin
            pinLocation = CLLocation(coordinate: pin.pinned, altitude: 80)
            let pinImage = pin.car
            let pinLocationNode = LocationAnnotationNode(location: pinLocation, image: pinImage)
            print(pinLocationNode)
            sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: pinLocationNode)
            
            //set up map
            let pinAnnotation: MKPointAnnotation = MKPointAnnotation()
            pinAnnotation.coordinate = pin.pinned
            pinAnnotation.title = "Pinned"
            map.addAnnotation(pinAnnotation)
            let currentAnnotation: MKPointAnnotation = MKPointAnnotation()
            currentAnnotation.coordinate = map.userLocation.coordinate
            let annotations:[MKAnnotation] = [pinAnnotation, currentAnnotation]
            map.showAnnotations(annotations, animated: true)
            map.removeAnnotation(currentAnnotation)
            
           //set up distance timer
            updateDistTimer = Timer.scheduledTimer(
                timeInterval: 0.5,
                target: self,
                selector: #selector(ViewController.UpdateDist),
                userInfo: nil,
                repeats: true)
        
        //add all subviews
        view.addSubview(sceneLocationView)
        view.addSubview(dist)
        view.addSubview(map)
        
        }
  
    }
  //Distance timer
  @objc func UpdateDist(){
        if let currentLocation = sceneLocationView.currentLocation(){
            let distanceInMeters = pinLocation.distance(from: currentLocation)
            let distInMiles = (distanceInMeters/1609.344)
            if distInMiles > 0.4 {
            dist.text = "\(String (format: "%.3f", distInMiles)) miles away"
            }else{
                dist.text = "\(String (format: "%.2f", distInMiles*1760)) yards away"
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sceneLocationView.frame = view.bounds
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension CLLocationCoordinate2D {
    // MARK: CLLocationCoordinate2D+MidPoint
    func middleLocationWith(location:CLLocationCoordinate2D) -> CLLocationCoordinate2D {
        
        let lon1 = longitude * Double.pi / 180
        let lon2 = location.longitude * Double.pi / 180
        let lat1 = latitude * Double.pi / 180
        let lat2 = location.latitude * Double.pi / 180
        let dLon = lon2 - lon1
        let x = cos(lat2) * cos(dLon)
        let y = cos(lat2) * sin(dLon)
        
        let lat3 = atan2( sin(lat1) + sin(lat2), sqrt((cos(lat1) + x) * (cos(lat1) + x) + y * y) )
        let lon3 = lon1 + atan2(y, cos(lat1) + x)
        
        let center:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat3 * 180 / Double.pi, lon3 * 180 / Double.pi)
        return center
    }
}



