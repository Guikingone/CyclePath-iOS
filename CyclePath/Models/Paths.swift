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
    private var date: String = ""
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
    
    var formattedDate: String {
        return date
    }
    
    var getLocations: [PathsLocationStruct.fetching] {
        return locations
    }
    
    init(distance: Double, duration: Int16, date: String, id: Int32)
    {
        self.distance = distance
        self.duration = duration
        self.date = date
        self.id = id
    }
    
    func linkLocations(locations: [PathsLocationStruct.fetching])
    {
        self.locations = locations
    }
    
    func transformStringToDate(date: Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, YYYY HH:mm"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+2:00")
        
        return dateFormatter.string(from: date)
    }
}
