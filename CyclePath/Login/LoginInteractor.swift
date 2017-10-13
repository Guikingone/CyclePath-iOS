//
//  LoginInteractor.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 13/10/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

import Foundation
import CoreLocation

class LoginInteractor
{
    func transformLocations(locations: [CLLocation], values: @escaping (_ : [HomeLocationStruct.persist], _ identifier: String) -> ())
    {
        DataTransformer().transformLocations(locations: locations) { (data, id) in
            values(data, id)
        }
    }
    
    func savePathByUser(pathId: String, distance: Any, duration: Int16, altitude: Double)
    {
        DataTransformer().savePathsByUser(pathId: pathId, distance: distance, duration: duration, altitude: altitude)
    }
    
    func saveLocationByPath(pathId: String, locations: [HomeLocationStruct.persist], success: @escaping (_: Bool) -> ())
    {
        DataTransformer().saveLocationByPath(pathId: pathId, locations: locations)
    }
}
