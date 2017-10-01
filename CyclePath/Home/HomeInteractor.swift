//
//  HomeInteractor.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 27/09/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

import MapKit
import Foundation
import CoreMotion
import CoreLocation

class HomeInteractor
{
    private var timer: Timer?
    private var seconds = 0
    private var distance = Measurement(value: 0, unit: UnitLength.meters)
    private var locationList: [CLLocation] = []
    var altimeterTracking = false
    let altimeterManager = CMAltimeter()
}

extension HomeInteractor: HomeInteractorProtocol
{
    // Location
    
    func centerMapOnUser(locationManager: CLLocationManager, mapView: MKMapView, regionRadius: Double)
    {
        guard let coordinates = locationManager.location?.coordinate else { return }
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(coordinates, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func startTracking()
    {
        seconds = 0
        distance = Measurement(value: 0, unit: UnitLength.meters)
        locationList.removeAll()
        updateDisplay()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.eachSeconds()
        }
    }
    
    func stopTimer()
    {
        timer?.invalidate()
    }
    
    func stopUpdatingLocation(locationManager: CLLocationManager)
    {
        locationManager.stopUpdatingLocation()
    }
    
    func eachSeconds()
    {
        seconds += 1
        updateDisplay()
    }
    
    func updateDisplay() -> Dictionary<String, Any>
    {
        let formattedDistance = HomeStruct.distance(distance)
        let formattedTime = HomeStruct.time(seconds)
        let formattedPace = HomeStruct.pace(distance: distance,
                                            seconds: seconds,
                                            outputUnit: UnitSpeed.minutesPerKilometer)
        
        return [
            "distance": formattedDistance,
            "time": formattedTime,
            "rythm": formattedPace
        ]
    }
    
    // Altimeter
    
    func checkAltimeterAvailability()
    {
        if CMAltimeter.isRelativeAltitudeAvailable() {
            altimeterTracking = true
        }
    }
    
    func startTrackingAltitude()
    {
        if altimeterTracking {
            altimeterManager.startRelativeAltitudeUpdates(to: OperationQueue.main, withHandler: { (data, errors) in
                if errors != nil {
                    print(errors?.localizedDescription as Any)
                }
                
                // TODO
            })
        }
    }
    
    func stopTrackingAltitude()
    {
        altimeterManager.stopRelativeAltitudeUpdates()
        
    }
    
    func saveAltitude()
    {
        
    }
}
