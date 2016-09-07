//
//  MapaViewController.swift
//  ContatosSwift
//
//  Created by Pedro Henrique on 06/09/16.
//  Copyright © 2016 IESB. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapaViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    var user: User?
    var manager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager = CLLocationManager()
        manager.delegate = self
        
        mapView.delegate = self
        mapView.showsUserLocation = false
        if let usuario = user {
            if let end = usuario.address {
                if let geo = end.geo {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2DMake(geo.lat!, geo.lng!)
                    annotation.title = usuario.name
                    annotation.subtitle = usuario.email
                    mapView.addAnnotation(annotation)
                }
            }
        }
        
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            manager.requestWhenInUseAuthorization()
        }
        manager.startUpdatingLocation()
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        mapView.showAnnotations(mapView.annotations, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedAlways || status == .AuthorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        if let location = locations.last {
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.coordinate
            annotation.title = "Localização do Usuário"
            
            mapView.addAnnotation(annotation)
        }
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let retorno = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "anotacao")
        if let title = annotation.title {
            if let titulo = title {
                if titulo == "Localização do Usuário" {
                    retorno.pinTintColor = UIColor.magentaColor()
                }else {
                    retorno.pinTintColor = UIColor.cyanColor()
                }
            }
        }
        retorno.animatesDrop = true
        
        mapView.showAnnotations(mapView.annotations, animated: true)
        
        return retorno
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
