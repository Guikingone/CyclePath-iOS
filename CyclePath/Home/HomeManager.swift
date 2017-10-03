//
//  HomeManager.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 01/10/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

import Firebase
import Foundation
import CoreLocation

class HomeManager
{
    
}

extension HomeManager
{
    func savePathsByUser(pathId: Int32, distance: Any, duration: Int16, success: @escaping (_: Bool) -> (), failure: @escaping (_: Bool) -> ())
    {
        DataService.instance.createPath(id: pathId, distance: distance, duration: duration)
    }
    
    func saveLocationByPath(pathId: Int32, locations: [HomeLocationStruct.persist], success: @escaping (_: Bool) -> (), failure: @escaping (_: Bool) -> ())
    {
        DataService.instance.createLocations(id: pathId, locations: locations)
    }
    
    func localPathStorage(path: HomePathStruct.create, success: @escaping (_: Bool) -> (), failure: @escaping (_: Bool) -> ())
    {
        
    }
}
