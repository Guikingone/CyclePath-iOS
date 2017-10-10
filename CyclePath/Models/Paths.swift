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
    private var altitude: Double = 0.0
    private var id: Int32 = 0
    private var locations = [Locations]()
    
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
    
    var getAltitude: Double {
        return altitude
    }
    
    var getLocations: [Locations] {
        return locations
    }
    
    init(distance: Double, duration: Int16, date: String, altitude: Double, id: Int32)
    {
        self.distance = distance
        self.duration = duration
        self.date = date
        self.altitude = altitude
        self.id = id
    }
    
    func linkLocations(locations: [Locations])
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
    
    func transformDateFromString(date: String) -> Date
    {
        let dateFormatted: DateFormatter = DateFormatter()
        dateFormatted.timeZone = TimeZone(abbreviation: "GMT+2:00")
        
        return dateFormatted.date(from: date)!
    }
    
    func transformMeters(meters: Double) -> Double
    {
        return Double()
    }
    
    func transformSecondsIntoMinutes(seconds: Int16) -> Double
    {
        if seconds < 60 {
            return Double("0.\(seconds)")!
        }
        
        return Double(seconds / 60)
    }
}
