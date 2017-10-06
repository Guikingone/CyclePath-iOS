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
    @IBOutlet weak var startBtn: CardButton!
    @IBOutlet weak var pauseBtn: CardButton!
    @IBOutlet weak var stopBtn: CardButton!
    
    @IBOutlet weak var dataCard: PathView!
    @IBOutlet weak var speedTxtLabel: UILabel!
    @IBOutlet weak var distanceTxtLabel: UILabel!
    @IBOutlet weak var timeTxtLabel: UILabel!
    @IBOutlet weak var altitudeLbl: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let authorizationStatus = CLLocationManager.authorizationStatus()
    
    private var timer: Timer?
    private var seconds = 0
    private var distance = Measurement(value: 0, unit: UnitLength.meters)
    private var locationList: [CLLocation] = []
    
    let altimeterManager = CMAltimeter()
    private var altimeterTracking: Bool = false
    private var altimeterData = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationManager.delegate = self
        mapView.showsUserLocation = true
        
        speedTxtLabel.text = ""
        distanceTxtLabel.text = ""
        timeTxtLabel.text = ""
        altitudeLbl.text = ""
        
        enableBasicLocationServices()
        
        HomeInteractor().checkAltimeterAvailability()
        
        pauseBtn.isHidden = true
        stopBtn.isHidden = true
    }
    
    @IBAction func findUser(_ sender: Any)
    {
        if authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse {
            HomeInteractor().centerMapOnUser(locationManager: locationManager, mapView: mapView, regionRadius: 1000)
        }
    }
    
    @IBAction func startTracking(_ sender: Any)
    {
        pauseBtn.isHidden = false
        stopBtn.isHidden = false
        
        mapView.removeOverlays(mapView.overlays)
        
        seconds = 0
        distance = Measurement(value: 0, unit: UnitLength.meters)
        locationList.removeAll()
        updateDisplay()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.eachSeconds()
        }
        
        startLocationUpdates()
        
        HomeInteractor().startTrackingAltitude()
    }
    
    @IBAction func pauseTracking(_ sender: Any)
    {
        // TODO: Invalide the timer and save temporarly the data in order to save or restart.
        startBtn.isHidden = true
        stopBtn.isHidden = true
        
        timer?.invalidate()
        
        let pauseAlert = UIAlertController(
            title: "Mettre en pause ?",
            message: "Voulez-vous sauvegarder ce suivi ?",
            preferredStyle: .alert
        )
        pauseAlert.addAction(UIAlertAction(
            title: "Reprendre", style: .default, handler: { (_) in
                // TODO: Resume the tracking.
                self.startBtn.isHidden = false
                self.stopBtn.isHidden = false
        }))
        pauseAlert.addAction(UIAlertAction(
            title: "Sauvegarder", style: .default, handler: { (_) in
                
                let actualData = HomePathStruct.pause(distance: self.distance.value, duration: Int16(self.seconds), locations: self.locationList)
                
                HomeInteractor().transformLocations(locations: actualData.locations, data: { (data, id) in
                    
                    HomeManager().savePathsByUser(pathId: id, distance: actualData.distance, duration: actualData.duration, success: { (saved) in
                        // TODO
                        print("saved !")
                    }, failure: { (failed) in
                        // TODO
                        print("Failed !")
                    })
                    
                    HomeManager().saveLocationByPath(pathId: id, locations: data, success: { (saved) in
                        // TODO
                    }, failure: { (failed) in
                        // TODO
                    })
                })
                
                self.startBtn.isHidden = false
        }))
        
        present(pauseAlert, animated: true, completion: nil)
    }
    
    @IBAction func stopTracking(_ sender: Any)
    {
        startBtn.isHidden = true
        pauseBtn.isHidden = true
        
        timer?.invalidate()
        HomeInteractor().stopUpdatingLocation(locationManager: locationManager)
        
        if Auth.auth().currentUser == nil {
            let alert = UIAlertController(
                title: "Are you logged in ?",
                message: "Do you want to save this path ?",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(
                title: "Save", style: .default, handler: { (_) in
                    self.performSegue(withIdentifier: "ShouldBeLoggedSegue", sender: self)
            }))
            
            self.present(alert, animated: true, completion: nil)
        } else {
            
            let stopAlert = UIAlertController(
                title: "Do you want to stop this track ?",
                message: "Do you want to save this path ?",
                preferredStyle: .alert
            )
            
            stopAlert.addAction(UIAlertAction(
                title: "Abort", style: .default, handler: { (_) in
                    
                    self.startBtn.isHidden = false
                    self.pauseBtn.isHidden = false
                    self.stopBtn.isHidden = false
            }))
            stopAlert.addAction(UIAlertAction(
                title: "Save", style: .default, handler: { (_) in
                    
                    HomeInteractor().transformLocations(locations: self.locationList, data: { (data, id) in
                        
                        HomeManager().savePathsByUser(pathId: id, distance: self.distance.value, duration: Int16(self.seconds), success: { (saved) in
                            // TODO
                            
                        }, failure: { (failed) in
                            // TODO
                            print("Failed !")
                        })
                        
                        HomeManager().saveLocationByPath(pathId: id, locations: data, success: { (saved) in
                            // TODO
                        }, failure: { (failed) in
                            // TODO
                        })
                    })
                    
                    self.startBtn.isHidden = false
                    self.pauseBtn.isHidden = false
            }))
            
            self.present(stopAlert, animated: true, completion: nil)
        }
        
        startBtn.isEnabled = true
    }
    
    func eachSeconds()
    {
        seconds += 1
        updateDisplay()
    }
    
    func updateDisplay()
    {
        let formattedDistance = HomeStruct.distance(distance)
        let formattedTime = HomeStruct.time(seconds)
        let formattedPace = HomeStruct.pace(distance: distance,
                                            seconds: seconds,
                                            outputUnit: UnitSpeed.minutesPerKilometer)
        
        distanceTxtLabel.text = formattedDistance
        timeTxtLabel.text = formattedTime
        speedTxtLabel.text = formattedPace
        altitudeLbl.text = String(format: "%.02f", HomeInteractor().getAltimeterData)
    }
    
    private func startLocationUpdates()
    {
        locationManager.delegate = self
        locationManager.activityType = .fitness
        locationManager.distanceFilter = 10
        locationManager.startUpdatingLocation()
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
        HomeInteractor().centerMapOnUser(locationManager: locationManager, mapView: mapView, regionRadius: 1000)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for newLocation in locations {
            let howRecent = newLocation.timestamp.timeIntervalSinceNow
            guard newLocation.horizontalAccuracy < 20 && abs(howRecent) < 10 else { continue }
            
            if let lastLocation = locationList.last {
                let delta = newLocation.distance(from: lastLocation)
                distance = distance + Measurement(value: delta, unit: UnitLength.meters)
                
                let coordinates = [lastLocation.coordinate, newLocation.coordinate]
                mapView.add(MKPolyline(coordinates: coordinates, count: 2))
                let region = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 500, 500)
                mapView.setRegion(region, animated: true)
            }
            
            locationList.append(newLocation)
        }
    }
}

extension HomeAction: MKMapViewDelegate
{
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyline = overlay as? MKPolyline else {
            return MKOverlayRenderer(overlay: overlay)
        }
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.strokeColor = .blue
        renderer.lineWidth = 3
        return renderer
    }
}
