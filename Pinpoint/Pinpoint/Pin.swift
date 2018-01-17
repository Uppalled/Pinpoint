//
//  Pin.swift
//  Pinpoint
//
//  Created by Harjap Uppal on 11/28/17.
//  Copyright © 2017 Harjap Uppal. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit
import os.log

class Pin: NSObject, NSCoding{
    
    
    let icon = Icons()
    var car:UIImage
    var pinned:CLLocationCoordinate2D
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("Pins")
    
    //MARK: Types
    
    struct PropertyKey {
        static let latitude = "latitude"
        static let longitude = "longitude"
        static let car = "car"
    }
    
    init(location: CLLocationCoordinate2D) {
        self.car = icon.car!
        self.pinned = location
    }
    
    func encode(with aCoder: NSCoder) {
       // aCoder.encode(pinned, forKey: PropertyKey.pinned)
        aCoder.encode(car, forKey: PropertyKey.car)
        aCoder.encode(pinned.latitude, forKey: "latitude")
        aCoder.encode(pinned.longitude, forKey: "longitude")
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let latitude = aDecoder.decodeDouble(forKey: "latitude")
        let longitude = aDecoder.decodeDouble(forKey: "longitude")
        let car = aDecoder.decodeObject(forKey: PropertyKey.car) as? UIImage
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.init(location:coordinate)

        
    } 
}

