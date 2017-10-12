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
    var path = Paths(distance: 0.0, duration: 0, date: "", altitude: 0.0, id: "", favorite: false)
    
    @IBOutlet weak var pathDateLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var averageAltimeterLbl: UILabel!
    @IBOutlet weak var averageRythm: UILabel!
    @IBOutlet weak var mapViewDetails: MKMapView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        mapViewDetails.delegate = self
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
        pathDateLbl.text = "Tracé du \(path.formattedDate)"
        distanceLbl.text = "\(path.transformMeters()) mètres"
        averageRythm.text = "\(path.transformSecondsIntoMinutes()) minutes"
        averageAltimeterLbl.text = "\(path.transformAltitude()) mètres"
        
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

    internal func polyLine() -> MKPolyline
    {
        let locations = path.getLocations
        
        let coords: [CLLocationCoordinate2D] = locations.map { location in
            let location = location as Locations
            return CLLocationCoordinate2D(latitude: location.getLatitude, longitude: location.getLongitude)
        }
        
        return MKPolyline(coordinates: coords, count: coords.count)
    }

    internal func loadMap()
    {
        let region = mapRegion()!

        mapViewDetails.setRegion(region, animated: true)
        mapViewDetails.add(polyLine())
    }
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
