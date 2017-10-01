//
//  AltimeterProtocol.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 01/10/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

protocol AltimeterProtocol
{
    func checkAltimeterAvailability()
    func startTrackingAltitude()
    func stopTrackingAltitude()
    func saveAltitude()
}
