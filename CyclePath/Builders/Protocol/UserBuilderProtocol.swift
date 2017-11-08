//
//  UserBuilderProtocol.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 08/11/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

import Foundation

protocol UserBuilderProtocol
{
    func create() -> UserBuilder
    
    func build() -> User
}
