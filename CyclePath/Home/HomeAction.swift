//
//  HomeAction.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 26/09/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import CoreMotion
import CoreLocation

class HomeAction: UIViewController
{
    @IBOutlet weak var sideMenuBtn: UIButton!
    @IBOutlet weak var profileImage: ProfileImage!
    @IBOutlet weak var dataCard: PathView!
    @IBOutlet weak var speedTxtLabel: UILabel!
    @IBOutlet weak var distanceTxtLabel: UILabel!
    @IBOutlet weak var timeTxtLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var trackBtn: CardButton!
    
    let locationManager = CLLocationManager()
    let altimeterManager = CMAltimeter()
    let authorizationStatus = CLLocationManager.authorizationStatus()
    private var altimeterTracking: Bool = false
    let regionRadius: Double = 1000
    private var seconds = 0
    private var timer: Timer?
    private var distance = Measurement(value: 0, unit: UnitLength.meters)
    private var locationList: [CLLocation] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationManager.delegate = self
        mapView.showsUserLocation = true
        
        speedTxtLabel.text = ""
        distanceTxtLabel.text = ""
        timeTxtLabel.text = ""
        
        enableBasicLocationServices()
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        timer?.invalidate()
//        HomeInteractor().stopUpdatingLocation(locationManager: locationManager)
//    }
    
    @IBAction func findUser(_ sender: Any)
    {
        if authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse {
            centerMapOnUserLocation()
        }
    }
    
    @IBAction func StartTracking(_ sender: Any)
    {
        trackBtn.animateButton(load: true, withMessage: nil)
        // TODO: Call the interactor and start tracking.
        seconds = 0
        distance = Measurement(value: 0, unit: UnitLength.meters)
        locationList.removeAll()
        updateDisplay()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.eachSeconds()
        }
        startLocationUpdates()
    }
    
    private func updateDisplay() {
        let formattedDistance = HomeStruct.distance(distance)
        let formattedTime = HomeStruct.time(seconds)
        let formattedPace = HomeStruct.pace(distance: distance,
                                            seconds: seconds,
                                            outputUnit: UnitSpeed.minutesPerKilometer)
        
        speedTxtLabel.text = formattedPace
        distanceTxtLabel.text = formattedDistance
        timeTxtLabel.text = formattedTime
    }
    
    func eachSeconds()
    {
        seconds += 1
        updateDisplay()
    }
    
    public func resetTimer()
    {
        timer?.invalidate()
    }
    
    private func startLocationUpdates() {
        locationManager.delegate = self
        locationManager.activityType = .fitness
        locationManager.distanceFilter = 10
        locationManager.startUpdatingLocation()
    }
}

extension HomeAction: MKMapViewDelegate
{
    func centerMapOnUserLocation()
    {
        guard let coordinates = locationManager.location?.coordinate else { return }
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(coordinates, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}

extension HomeAction: CLLocationManagerDelegate
{
    func enableBasicLocationServices() {
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            // Request when-in-use authorization initially
            locationManager.requestWhenInUseAuthorization()
            break
            
        case .restricted, .denied:
            // Disable location features
            break
            
        case .authorizedWhenInUse, .authorizedAlways:
            // Enable location features
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
        centerMapOnUserLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for newLocation in locations {
            let howRecent = newLocation.timestamp.timeIntervalSinceNow
            guard newLocation.horizontalAccuracy < 20 && abs(howRecent) < 10 else { continue }
            
            if let lastLocation = locationList.last {
                let delta = newLocation.distance(from: lastLocation)
                distance = distance + Measurement(value: delta, unit: UnitLength.meters)
            }
            
            locationList.append(newLocation)
        }
    }
}

extension HomeAction: AltimeterProtocol
{
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
        // TODO
    }
    
    func saveAltitude()
    {
        HomeManager().savePathsByUser(uid: (Auth.auth().currentUser?.uid)!)
    }
}
