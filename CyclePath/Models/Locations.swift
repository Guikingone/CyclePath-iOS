//
//  Locations.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 05/10/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

import Foundation

class Locations
{
    private var latitude: Double = 0.0
    private var longitude: Double = 0.0
    private var date: String = ""
    private var id: String = ""
    
    var getLatitude: Double {
        return latitude
    }
    
    var getLongitude: Double {
        return longitude
    }
    
    var getDate: String {
        return date
    }
    
    var getId: String {
        return id
    }
    
    init(latitude: Double, longitude: Double, date: String, identifier: String)
    {
        self.latitude = latitude
        self.longitude = longitude
        self.date = date
        self.id = identifier
    }
    
    func transformDateFromString(date: String) -> Date
    {
        let dateFormatted: DateFormatter = DateFormatter()
        dateFormatted.timeZone = TimeZone(abbreviation: "GMT+2:00")
        var formatted = dateFormatted.date(from: date)!
        
        print(date, formatted)
        
        return dateFormatted.date(from: self.getDate)!
    }
}
