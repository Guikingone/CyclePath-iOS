//
//  HomeManagerProtocol.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 01/10/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

import CoreLocation

protocol HomeManagerProtocol
{
    func savePathsByUser(distance: Any, duration: Int16, locations: [CLLocation], success: @escaping (_: Bool) -> (), failure: @escaping (_: Bool) -> ())
    
    func localPathStorage(path: TrackingPathStruct.create, success: @escaping (_: Bool) -> (), failure: @escaping (_: Bool) -> ())
}
