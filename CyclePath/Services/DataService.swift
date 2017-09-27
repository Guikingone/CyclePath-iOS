//
//  AuthService.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 26/09/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

class DataService
{
    static let instance = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_PATHS = DB_BASE.child("path")
    private var _REF_LOCATIONS = DB_BASE.child("location")
    
    var REF_BASER: DatabaseReference {
        return DB_BASE
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    var REF_PATHS: DatabaseReference {
        return _REF_PATHS
    }
    
    var REF_LOCATIONS: DatabaseReference {
        return _REF_LOCATIONS
    }
    
    public func createUser(uid: String, data: Dictionary<String, Any>)
    {
        REF_USERS.child(uid).updateChildValues(data)
    }
    
    public func createPath(uid: String, data: Dictionary<String, Any>)
    {
        REF_PATHS.child(uid).updateChildValues(data)
    }
    
    public func createLocation()
    {
        
    }
}
