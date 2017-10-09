//
//  LocationStruct.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 02/10/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

import Foundation

struct HomeLocationStruct
{
    struct create
    {
        let timestamp: Date
        let latitude: Double
        let longitude: Double
    }
    
    struct persist
    {
        let path: Int32
        let timestamp: Date
        let latitude: Double
        let longitude: Double
    }
}
