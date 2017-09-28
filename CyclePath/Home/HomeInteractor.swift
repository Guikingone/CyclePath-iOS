//
//  HomeInteractor.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 27/09/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

import Foundation
import CoreLocation

class HomeInteractor
{
    func stopUpdatingLocation(locationManager: CLLocationManager)
    {
        locationManager.stopUpdatingLocation()
    }
}
