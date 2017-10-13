//
//  DataTransformer.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 13/10/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

import Foundation
import CoreLocation

class DataTransformer
{
    func transformLocations(locations: [CLLocation], data: @escaping (_ : [HomeLocationStruct.persist], _ identifier: String) -> ())
    {
        var locationArray = [HomeLocationStruct.persist]()
        let id = String(describing: arc4random_uniform(44000))
        
        for location in locations {
            
            let locationStruct = HomeLocationStruct.persist(path: id, timestamp: location.timestamp, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            locationArray.append(locationStruct)
        }
        
        data(locationArray, id)
    }
    
    func savePathsByUser(pathId: String, distance: Any, duration: Int16, altitude: Double)
    {
        DataService.instance.createPath(id: pathId, distance: distance, duration: duration, altitude: altitude)
    }
    
    func saveLocationByPath(pathId: String, locations: [HomeLocationStruct.persist])
    {
        DataService.instance.createLocations(id: pathId, locations: locations)
    }
}
