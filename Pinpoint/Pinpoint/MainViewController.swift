//
//  MainViewController.swift
//  Pinpoint
//
//  Created by Harjap Uppal on 11/26/17.
//  Copyright © 2017 Harjap Uppal. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import os.log

class MainViewController: UITableViewController{
    public var Pins = [Pin]()
    var selected:Pin!
    override func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Pins.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "viewTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? viewTableViewCell
        
        let pin = Pins[indexPath.row]
        let annotation = MKPointAnnotation()
        annotation.coordinate = pin.pinned
        annotation.title = "Pin"
        cell?.Map.addAnnotation(annotation)
        let center = annotation.coordinate
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        cell?.Map.setRegion(region, animated: true)
        return cell!
    }
    
    // Override to edit the list of pins
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            Pins.remove(at: indexPath.row)
            savePins()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.rowHeight = 150;
        
        navigationItem.leftBarButtonItem = editButtonItem
        
       // Load any saved meals, otherwise load sample data.
        if let savedPins = loadPins() {
            Pins += savedPins
        }
        else {
            // Load the sample data.
            loadSample()
        }
      //  loadSample()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var Table: UITableView!
    
    

    //Sample locations for testing purposes
    private func loadSample() {
        let l1 = CLLocationCoordinate2D(latitude: 39.964327, longitude: -75.283344)
        let v1 = Pin(location: l1)
        let l2 = CLLocationCoordinate2D(latitude: 39.964327, longitude: -75.283344)
        let v2 = Pin(location: l2)
        let l3 = CLLocationCoordinate2D(latitude: 39.964327, longitude: -75.283344)
        let v3 = Pin(location: l3)
        Pins += [v1,v2,v3]
        
    }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        if let selectedPin = sender as? viewTableViewCell{
        
        
        guard let viewViewController = segue.destination as? ViewController else {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        
        guard let indexPath = tableView.indexPath(for: selectedPin) else {
            fatalError("The selected cell is not being displayed by the table")
        }
        
        let selected = Pins[indexPath.row]
        viewViewController.pin = selected
        print(selected)
        }
    
    }
    
    //MARK: Navigation
    @IBAction func unwindToPinsList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddPinViewController, let pin = sourceViewController.coordinate {
            // Add a new task.
            let newIndexPath = IndexPath(row: Pins.count, section: 0)
            let Pinned = Pin(location: pin)
            Pins.append(Pinned)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            savePins()
        }
        
    }
    
    
    
    //MARK: Actions
    
   private func savePins() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(Pins, toFile: Pin.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Pins successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save pins...", log: OSLog.default, type: .error)
        }
    }
    private func loadPins() -> [Pin]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Pin.ArchiveURL.path) as? [Pin]
    }
}
