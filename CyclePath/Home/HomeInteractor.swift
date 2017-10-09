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
    let locationManager = CLLocationManager()
    
    var altimeterTracking = false
    let altimeterManager = CMAltimeter()
    private var altimeterData: [Double] = []
    private var altimeterSum: Double = 0.0
    
    private var currentDistance: String = ""
    private var currentTime: String = ""
    private var currentPace: String = ""
    
    // Altimeter
    
    var getAltimeterData: [Double] {
        return altimeterData
    }
    
    var getAltimeterSum: Double {
        return altimeterSum
    }
    
    // Timer
    
    func setCurrentTimer(timer: Timer) {
        self.timer = timer
    }
    
    var getCurrentTimer: Timer {
        return self.timer!
    }
    
    // Location
    
    var getCurrentDistance: String {
        return currentDistance
    }
    
    var getCurrentTime: String {
        return currentTime
    }
    
    var getCurrentPace: String {
        return currentPace
    }
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
    
    func startTracking(handledData: @escaping (_: Int, _: Measurement<UnitLength>,  _: [CLLocation]) -> ())
    {
        let seconds = 0
        var locationList: [CLLocation] = []
        locationList.removeAll()
        
        let distance = Measurement(value: 0, unit: UnitLength.meters)
        
        handledData(seconds, distance, locationList)
    }
    
    func pauseTracking(seconds: Int16, distance: Double, locations: [CLLocation]) -> TrackingPathStruct.pause
    {
        return HomeManager().pauseTracking(seconds: seconds, distance: distance, locations: locations)
    }
    
    func resumeTracking(actualData: TrackingPathStruct.pause)
    {
        
    }
    
    func stopTracking(seconds: Int16, distance: Double, locations: [CLLocation]) -> TrackingPathStruct.stop
    {
        return HomeManager().stopTracking(seconds: seconds, distance: distance, locations: locations)
    }
    
    func restartTracking(locationManager: CLLocationManager)
    {
        stopUpdatingLocation(locationManager: locationManager)
    }
    
    func stopTimer()
    {
        timer?.invalidate()
    }
    
    func stopUpdatingLocation(locationManager: CLLocationManager)
    {
        locationManager.stopUpdatingLocation()
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
        if CMAltimeter.isRelativeAltitudeAvailable() {
            altimeterManager.startRelativeAltitudeUpdates(to: OperationQueue.main, withHandler: { (data, errors) in
                if errors != nil {
                    print(errors?.localizedDescription as Any)
                }
                
                self.altimeterData = [(data?.relativeAltitude.doubleValue)!]
            })
        }
    }
    
    func stopTrackingAltitude()
    {
        altimeterManager.stopRelativeAltitudeUpdates()
        
    }
    
    func countAltitudeEntry()
    {
        let altimeterCount = Double(altimeterData.count)
        var altimeterLevel: Double = 0.0
        
        for altimeter in altimeterData {
            altimeterLevel += altimeter
            self.altimeterSum = altimeterLevel / altimeterCount
        }
    }
    
    func saveAltitude(altitudeSum: Double)
    {
        
    }
    
    func transformLocations(locations: [CLLocation], data: @escaping (_ : [HomeLocationStruct.persist], _ identifier: Int32) -> ())
    {
        var locationArray = [HomeLocationStruct.persist]()
        let id = arc4random_uniform(44000)
        
        for location in locations {
            
            let locationStruct = HomeLocationStruct.persist(path: Int32(id), timestamp: location.timestamp, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            locationArray.append(locationStruct)
        }
        
        data(locationArray, Int32(id))
    }
}
