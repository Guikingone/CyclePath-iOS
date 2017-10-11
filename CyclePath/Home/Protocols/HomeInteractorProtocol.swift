//
//  HomeInteractorProtocol.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 01/10/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

import MapKit
import CoreLocation

protocol HomeInteractorProtocol
{
    func centerMapOnUser(locationManager: CLLocationManager, mapView: MKMapView, regionRadius: Double)
    
    func stopTimer()
    
    func stopUpdatingLocation(locationManager: CLLocationManager)
    
    // Altimeter
    
    func checkAltimeterAvailability()
    
    func startTrackingAltitude()
    
    func stopTrackingAltitude()
    
    func countAltitudeEntry()
    
    func saveAltitude(altitudeSum: Double)
    
    // Logic
    
    func transformLocations(locations: [CLLocation], data: @escaping (_ : [HomeLocationStruct.persist], _ : String) -> ())
}
