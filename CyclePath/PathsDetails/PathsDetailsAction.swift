//
//  PathsDetailsAction.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 02/10/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

import UIKit
import MapKit

class PathsDetailsAction: UIViewController
{
    var path = Paths(distance: 0.0, duration: 0, date: "", id: 0)
    
    @IBOutlet weak var pathDateLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var averageAltimeterLbl: UILabel!
    @IBOutlet weak var averageRythm: UILabel!
    @IBOutlet weak var mapViewDetails: MKMapView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // configureView()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        displayInformations()
    }
    
    @IBAction func backBtn(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
}

extension PathsDetailsAction
{
    func displayInformations()
    {
        pathDateLbl.text = "Path of \(path.formattedDate)"
        distanceLbl.text = "\(String(describing: path.formattedDistance)) meters"
        averageRythm.text = "\(path.formattedDuration)"
        averageAltimeterLbl.text = ""
    }
    
    internal func configureView()
    {
        let distance = Measurement(value: path.formattedDistance, unit: UnitLength.meters)
        let seconds = Int(path.formattedDuration)
        let formattedDistance = HomeStruct.distance(distance)
        // let formattedDate = HomeStruct.date(path.formattedDate)
        let formattedTime = HomeStruct.time(seconds)
        let formattedPace = HomeStruct.pace(distance: distance,
                                               seconds: seconds,
                                               outputUnit: UnitSpeed.minutesPerMile)
        
        //loadMap()
    }
    
//    internal func mapRegion() -> MKCoordinateRegion?
//    {
//        guard
//            let locations = path.getLocations,
//            locations.count > 0
//            else {
//                return nil
//        }
//
//        let latitudes = locations.map { location -> Double in
//            let location = location as! Location
//            return location.lattitude
//        }
//
//        let longitudes = locations.map { location -> Double in
//            let location = location as! Location
//            return location.longitude
//        }
//
//        let maxLat = latitudes.max()!
//        let minLat = latitudes.min()!
//        let maxLong = longitudes.max()!
//        let minLong = longitudes.min()!
//
//        let center = CLLocationCoordinate2D(latitude: (minLat + maxLat) / 2,
//                                            longitude: (minLong + maxLong) / 2)
//        let span = MKCoordinateSpan(latitudeDelta: (maxLat - minLat) * 1.3,
//                                    longitudeDelta: (maxLong - minLong) * 1.3)
//
//        return MKCoordinateRegion(center: center, span: span)
//    }
//
//    internal func polyLine() -> MKPolyline
//    {
//        guard let locations = path.getLocations else {
//            return MKPolyline()
//        }
//
//        let coords: [CLLocationCoordinate2D] = locations.map { location in
//            let location = location as! Location
//            return CLLocationCoordinate2D(latitude: location.lattitude, longitude: location.longitude)
//        }
//        return MKPolyline(coordinates: coords, count: coords.count)
//    }
//
//    internal func loadMap() {
//        guard
//            let locations = path.getLocations,
//            locations.count > 0,
//            let region = mapRegion()
//            else {
//                let alert = UIAlertController(title: "Error",
//                                              message: "Sorry, this run has no locations saved",
//                                              preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
//                present(alert, animated: true)
//                return
//        }
//
//        mapViewDetails.setRegion(region, animated: true)
//        mapViewDetails.add(polyLine())
//    }
}

extension PathsDetailsAction: MKMapViewDelegate
{
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyline = overlay as? MKPolyline else {
            return MKOverlayRenderer(overlay: overlay)
        }
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.strokeColor = .black
        renderer.lineWidth = 3
        
        return renderer
    }
}
