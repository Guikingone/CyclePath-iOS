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
    func savePathsByUser(distance: Any, duration: Int16, locations: [LocationStruct.persist], success: @escaping (_: Bool) -> (), failure: @escaping (_: Bool) -> ())
    {
        DataService.instance.createPath(distance: distance, duration: duration, locations: locations)
    }
}
