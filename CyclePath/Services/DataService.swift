//
//  AuthService.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 26/09/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

import Foundation
import Firebase
import CoreLocation

let DB_BASE = Database.database().reference()

class DataService
{
    static let instance = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_PATHS = DB_BASE.child("path")
    private var _REF_LOCATIONS = DB_BASE.child("location")
    
    private var paths = [Paths]()
    
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
    
    var getPaths: [Paths] {
        return paths
    }
    
    public func createUser(uid: String, data: Dictionary<String, Any>)
    {
        REF_USERS.child(uid).updateChildValues(data)
    }
    
    public func createPath(distance: Any, duration: Int16, locations: [CLLocation])
    {
        let data = [
            "user": Auth.auth().currentUser?.uid,
            "distance": distance,
            "duration": duration,
            "timestamp": String(describing: Date()),
            "locations": locations
        ]
        
        REF_PATHS.childByAutoId().updateChildValues(data)
    }
    
    public func getPathsByUser(handler: @escaping (_ receivedData: [Paths]) -> ())
    {
        REF_PATHS.observeSingleEvent(of: .value) { (receivedDataSnapshot) in
            guard let receivedData = receivedDataSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for data in receivedData {
                if data.childSnapshot(forPath: "user").value as? String == Auth.auth().currentUser?.uid {
                    let distance = data.childSnapshot(forPath: "distance").value as! Int
                    let duration = data.childSnapshot(forPath: "duration").value as! Int16
                    let timestamp = data.childSnapshot(forPath: "timestamp").value as! String
                    let path = Paths(distance: distance, duration: duration, timestamp: timestamp)
                    
                    self.paths.append(path)
                } else {
                    print("You must be logged in !")
                }
            }
            
            handler(self.paths)
        }
    }
    
    public func createLocation()
    {
        
    }
}
