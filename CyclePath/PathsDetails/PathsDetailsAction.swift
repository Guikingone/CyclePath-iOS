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
        
        mapViewDetails.delegate = self
        
        displayInformations()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        displayInformations()
    }
    
    @IBAction func backBtn(_ sender: Any)
    {
        dismissDetails()
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
        
        if path.getLocations.count > 0 {
            
            loadMap()
        } else {
            return
        }
    }

    internal func mapRegion() -> MKCoordinateRegion?
    {
        let locations = path.getLocations

        let latitudes = locations.map { location -> Double in
            let location = location as Locations
            return location.getLatitude
        }

        let longitudes = locations.map { location -> Double in
            let location = location as Locations
            return location.getLongitude
        }

        let maxLat = latitudes.max()!
        let minLat = latitudes.min()!
        let maxLong = longitudes.max()!
        let minLong = longitudes.min()!

        let center = CLLocationCoordinate2D(latitude: (minLat + maxLat) / 2,
                                            longitude: (minLong + maxLong) / 2)
        let span = MKCoordinateSpan(latitudeDelta: (maxLat - minLat) * 1.3,
                                    longitudeDelta: (maxLong - minLong) * 1.3)

        return MKCoordinateRegion(center: center, span: span)
    }

    internal func polyLine() -> [MapColorLine]
    {
        let locations = path.getLocations
        var coordinates: [(CLLocation, CLLocation)] = []
        var speeds: [Double] = []
        var minSpeed = Double.greatestFiniteMagnitude
        var maxSpeed = 0.0
        
        // 2
        for (first, second) in zip(locations, locations.dropFirst()) {
            let start = CLLocation(latitude: first.getLatitude, longitude: first.getLongitude)
            let end = CLLocation(latitude: second.getLatitude, longitude: second.getLongitude)
            coordinates.append((start, end))
            
            //3
            let distance = end.distance(from: start)
            
            let formattedTime = second.transformDateFromString(date: second.getDate) as Date
            let firstFormattedTime = first.transformDateFromString(date: first.getDate) as Date
            let differenceTime = formattedTime.timeIntervalSince(formattedTime)
            let time = formattedTime.timeIntervalSince(formattedTime)
            
            let speed = differenceTime > 0 ? distance / differenceTime : 0
            speeds.append(speed)
            minSpeed = min(minSpeed, speed)
            maxSpeed = max(maxSpeed, speed)
        }
        
        //4
        let midSpeed = speeds.reduce(0, +) / Double(speeds.count)
        
        //5
        var segments: [MapColorLine] = []
        
        for ((start, end), speed) in zip(coordinates, speeds) {
            let coords = [start.coordinate, end.coordinate]
            let segment = MapColorLine(coordinates: coords, count: 2)
            segment.color = segment.segmentColor(speed: speed,
                                         midSpeed: midSpeed,
                                         slowestSpeed: minSpeed,
                                         fastestSpeed: maxSpeed)
            segments.append(segment)
        }
        
        return segments
    }

    internal func loadMap()
    {
        let locations = path.getLocations
        let region = mapRegion()!

        mapViewDetails.setRegion(region, animated: true)
        mapViewDetails.addOverlays(polyLine())
    }
}

extension PathsDetailsAction: MKMapViewDelegate
{
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyline = overlay as? MapColorLine else {
            return MKOverlayRenderer(overlay: overlay)
        }
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.strokeColor = polyline.color
        renderer.lineWidth = 3
        return renderer
    }
}
