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
    
    public func createPath(id: Int32, distance: Any, duration: Int16)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, YYYY HH:mm"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+2:00")
        
        let date = Date()
        let formattedDate = dateFormatter.string(from: date)
        
        let data = [
            "user": Auth.auth().currentUser?.uid,
            "distance": distance,
            "duration": duration,
            "date": formattedDate,
            "id": id
        ]
        
        REF_PATHS.childByAutoId().updateChildValues(data)
    }
    
    public func getPathsByUser(handler: @escaping (_ receivedData: [Paths]) -> ())
    {
        REF_PATHS.observeSingleEvent(of: .value) { (receivedDataSnapshot) in
            
            var pathsList = [Paths]()
            guard let receivedData = receivedDataSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for data in receivedData {
                
                if data.childSnapshot(forPath: "user").value as? String == Auth.auth().currentUser?.uid {
                    let distance = data.childSnapshot(forPath: "distance").value as! Double
                    let duration = data.childSnapshot(forPath: "duration").value as! Int16
                    let date = data.childSnapshot(forPath: "date").value as! String
                    let id = data.childSnapshot(forPath: "id").value as! Int32
                    
                    let path = Paths(distance: distance, duration: duration, date: date, id: id)
                    
                    pathsList.append(path)
                    
                } else {
                    print("You must be logged in !")
                }
            }
            
            for path in pathsList {
                
                // Call the locations handler in order to store the locations inside the path.
                self.getLocationsByPath(identifier: path.getId, handler: { (locations) in
                    path.linkLocations(locations: locations)
                })
            }
            
            handler(pathsList)
        }
    }
    
    public func createLocations(id: Int32, locations: [HomeLocationStruct.persist])
    {
        for location in locations {
            
            let array: [String: Any] = [
                "id": id,
                "timestamp": String(describing: location.timestamp),
                "latitude": location.latitude,
                "longitude": location.longitude
            ]
            
            REF_LOCATIONS.childByAutoId().updateChildValues(array)
        }
    }
    
    public func getLocationsByPath(identifier: Int32, handler: @escaping (_: [Locations]) -> ())
    {
        REF_LOCATIONS.observeSingleEvent(of: DataEventType.value) { (receivedData) in
            var locationsLists = [Locations]()
            
            guard let receivedLocations = receivedData.children.allObjects as? [DataSnapshot] else { return }
            
            for data in receivedLocations {
                
                if data.childSnapshot(forPath: "id").value as! Int32 == identifier {
                    
                    let latitude = data.childSnapshot(forPath: "latitude").value as! Double
                    let longitude = data.childSnapshot(forPath: "longitude").value as! Double
                    let timestamp = data.childSnapshot(forPath: "timestamp").value as! String
                    
                    let location = Locations(latitude: latitude, longitude: longitude, date: timestamp, identifier: identifier)
                    
                    locationsLists.append(location)
                }
            }
            
            handler(locationsLists)
            
        }
    }
}
