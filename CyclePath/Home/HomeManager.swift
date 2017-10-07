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
    func savePathsByUser(pathId: Int32, distance: Any, duration: Int16, success: @escaping (_: Bool) -> ())
    {
        DataService.instance.createPath(id: pathId, distance: distance, duration: duration)
        success(true)
    }
    
    func saveLocationByPath(pathId: Int32, locations: [HomeLocationStruct.persist], success: @escaping (_: Bool) -> ())
    {
        DataService.instance.createLocations(id: pathId, locations: locations)
        success(true)
    }
    
    func pauseTracking(seconds: Int16, distance: Double, locations: [CLLocation]) -> TrackingPathStruct.pause
    {
       return TrackingPathStruct.pause(distance: distance, duration: seconds, locations: locations)
    }
    
    func stopTracking(seconds: Int16, distance: Double, locations: [CLLocation]) -> TrackingPathStruct.stop
    {
        return TrackingPathStruct.stop(distance: distance, duration: seconds, locations: locations)
    }
    
    func localPathStorage(path: TrackingPathStruct.create, success: @escaping (_: Bool) -> (), failure: @escaping (_: Bool) -> ())
    {
        
    }
}
