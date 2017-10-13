//
//  PathStruct.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 03/10/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

import CoreLocation

struct TrackingPathStruct
{
    struct create
    {
        let distance: Double
        let duration: Int16
        let timestamp: Date
        let locations: [HomeLocationStruct.create]
    }
    
    struct pause
    {
        let distance: Double
        let duration: Int16
        let locations: [CLLocation]
        let altitude: Double
    }
    
    struct stop
    {
        let distance: Double
        let duration: Int16
        let locations: [CLLocation]
        let altitude: Double
    }
}
