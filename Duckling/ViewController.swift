//
//  ViewController.swift
//  Duckling
//
//  Created by t-matsumura on 4/14/15.
//  Copyright (c) 2015 Humour Studio. All rights reserved.
//

import UIKit
import CoreLocation
import Argo

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    var region: CLBeaconRegion?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var parseError: NSError?
        let idFilePath: String? = NSBundle.mainBundle().pathForResource("identifiers.json", ofType: nil)
        let idData = NSData(contentsOfFile: idFilePath!)
        let idJson: AnyObject? = NSJSONSerialization.JSONObjectWithData(idData!, options: NSJSONReadingOptions(0), error: &parseError)
        
        if let j: AnyObject = idJson {
            let value: JSONValue = JSONValue.parse(j)
            let identifiers: Identifiers? = Identifiers.decode(value)
            
            println(identifiers)
            
            region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: identifiers!.uuid), identifier: "sample")
        }
        
        locationManager.delegate = self;
        
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedAlways) {
            locationManager.requestAlwaysAuthorization()
        }
        
        locationManager.startRangingBeaconsInRegion(region);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        println(beacons)
    }
}

