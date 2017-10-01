//
//  HomeManager.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 01/10/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

import Foundation
import Firebase

class HomeManager
{
    
}

extension HomeManager: HomeManagerProtocol
{
    func savePathsByUser(uid: String, data: Dictionary<String, Any>)
    {
        DataService.instance.createPath(uid: uid, data: data)
    }
}
