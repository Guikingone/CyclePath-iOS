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
    private var id: String = ""
    private var favorite: Bool = false
    private var locations = [Locations]()
    
    var getId: String {
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
    
    var isFavorite: Bool {
        return favorite
    }
    
    var getLocations: [Locations] {
        return locations
    }
    
    init(distance: Double, duration: Int16, date: String, altitude: Double, id: String, favorite: Bool)
    {
        self.distance = distance
        self.duration = duration
        self.date = date
        self.altitude = altitude
        self.id = id
        self.favorite = favorite
    }
    
    func linkLocations(locations: [Locations])
    {
        self.locations = locations
    }
    
    func createDate() -> String
    {
        let dateFormatter = DateFormatter()
        let date = Date()
        dateFormatter.dateFormat = "d MMMM YYYY - HH:mm"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+2:00")
        
        return dateFormatter.string(from: date)
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
    
    func transformMeters() -> String
    {
        return String(format: "%.02f", formattedDistance)
    }
    
    func transformSecondsIntoMinutes() -> String
    {
        if formattedDuration < 60 {
            return String(describing: "0.\(formattedDuration)")
        }
        
        return String(format: "%.02f", Double(formattedDuration / 60))
    }
    
    func transformAltitude() -> String
    {
        return String(format: "%.02f", getAltitude)
    }
}
