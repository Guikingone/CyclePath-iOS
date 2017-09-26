//
//  HomeAction.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 26/09/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class HomeAction: UIViewController, MKMapViewDelegate
{
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var trackBtn: CardButton!
    
    var manager = CLLocationManager()
    
    var regionRadius: CLLocationDistance = 1000
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        manager = CLLocationManager()
        isAuthorizedToTrack()
        
        mapView.delegate = self
        
        centerMapOnUserLocation()
    }
    
    func isAuthorizedToTrack()
    {
        if CLLocationManager.authorizationStatus() == .authorizedAlways {
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.startUpdatingLocation()
        } else {
            manager.requestAlwaysAuthorization()
        }
    }
    
    func centerMapOnUserLocation()
    {
        let coordinates = MKCoordinateRegionMakeWithDistance(mapView.userLocation.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        
        mapView.setRegion(coordinates, animated: true)
    }
    
    @IBAction func findUser(_ sender: Any)
    {
        
    }
    
    @IBAction func StartTracking(_ sender: Any)
    {
        trackBtn.animateButton(load: true, withMessage: nil)
    }
}

extension HomeAction: CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            isAuthorizedToTrack()
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .follow
        }
    }
}
