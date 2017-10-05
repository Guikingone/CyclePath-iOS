//
//  PathDetailsProtocol.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 02/10/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

import MapKit

protocol PathsDetailsProtocol
{
    func displayInformations()
    
    func configureView()
    
    func mapRegion() -> MKCoordinateRegion?
    
    func polyLine() -> MKPolyline
    
    func loadMap()
}
