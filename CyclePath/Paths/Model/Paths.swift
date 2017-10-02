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
    private var distance: Int = 0
    private var duration: Int16 = 0
    private var timestamp: String = ""
    
    var formattedDistance: Int {
        return distance
    }
    
    var formattedDuration: Int16 {
        return duration
    }
    
    var formattedTimestamp: String {
        return timestamp
    }
    
    init(distance: Int, duration: Int16, timestamp: String)
    {
        self.distance = distance
        self.duration = duration
        self.timestamp = timestamp
    }
}
