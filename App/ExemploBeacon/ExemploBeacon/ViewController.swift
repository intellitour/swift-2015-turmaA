//
//  ViewController.swift
//  ExemploBeacon
//
//  Created by Pedro Henrique on 06/09/16.
//  Copyright © 2016 IESB. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var manager: CLLocationManager!
    var beaconRegion: CLBeaconRegion!

    override func viewDidLoad() {
        super.viewDidLoad()
        manager = CLLocationManager()
        manager.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            manager.requestWhenInUseAuthorization()
        }
        
        
        if let uuid = NSUUID(UUIDString: "B0702880-A295-A8AB-F734-031A98A512DE") {
            beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: 1000, minor: 5, identifier: "IESB")
            beaconRegion.notifyOnEntry = true
            beaconRegion.notifyOnExit = true
            manager.startRangingBeaconsInRegion(beaconRegion)
        }
    }
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        if beacons.count > 0 {
            if let beaconMaisProximo = beacons.first {
               let proximidade = beaconMaisProximo.proximity
                switch proximidade {
                    case .Immediate:
                        print("Tá quente!")
                        break
                    case .Near:
                        print("Morno")
                        break
                    case .Far:
                        print("Frio")
                        break
                    default:
                        print("Cadê meu beacon?")
                        break
                }
            }
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
    
    func locationManager(manager: CLLocationManager, monitoringDidFailForRegion region: CLRegion?, withError error: NSError) {
        print(error)
    }
    
    func locationManager(manager: CLLocationManager, rangingBeaconsDidFailForRegion region: CLBeaconRegion, withError error: NSError) {
        print(error)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

