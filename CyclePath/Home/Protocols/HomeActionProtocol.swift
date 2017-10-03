//
//  HomeActionProtocol.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 01/10/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

protocol HomeActionProtocol
{
    func checkLocationAccess()
    
    func checkUserAuthenticated()
    
    func startTracking()
    
    func pauseTracking()
    
    func stopTracking()
}
