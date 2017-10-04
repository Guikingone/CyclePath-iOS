//
//  Paths.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 02/10/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

import Foundation

class Paths
{
    private var distance: Double = 0
    private var duration: Int16 = 0
    private var timestamp: String = ""
    private var id: Int32 = 0
    private var locations = [PathsLocationStruct.fetching]()
    
    var getId: Int32 {
        return id
    }
    
    var formattedDistance: Double {
        return distance
    }
    
    var formattedDuration: Int16 {
        return duration
    }
    
    var formattedTimestamp: String {
        return timestamp
    }
    
    init(distance: Double, duration: Int16, timestamp: String, id: Int32)
    {
        self.distance = distance
        self.duration = duration
        self.timestamp = timestamp
        self.id = id
    }
    
    func linkLocations(locations: [PathsLocationStruct.fetching])
    {
        self.locations = locations
    }
}
