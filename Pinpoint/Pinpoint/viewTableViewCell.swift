//
//  viewTableViewCell.swift
//  Pinpoint
//
//  Created by Harjap Uppal on 11/26/17.
//  Copyright © 2017 Harjap Uppal. All rights reserved.
//

import UIKit
import MapKit

class viewTableViewCell: UITableViewCell {

    @IBOutlet weak var Map: MKMapView!
    var coordinate: CLLocationCoordinate2D!

    @IBOutlet weak var view: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    

}
