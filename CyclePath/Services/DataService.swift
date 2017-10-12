//
//  AuthService.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 26/09/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

import Firebase
import FirebaseStorage
import Foundation
import SDWebImage
import CoreLocation

let DB_BASE = Database.database().reference()
let STORAGE_BASE = Storage.storage().reference()

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
    
    func getActualUser(handler: @escaping (_: User) -> ())
    {
        let actualUser = Auth.auth().currentUser?.uid
        
        let child = REF_USERS.child(actualUser!)
        
        child.observeSingleEvent(of: .value) { (receivedSnapShot) in
            let user = User()
            
            guard let receivedData = receivedSnapShot.children.allObjects as? [DataSnapshot] else { return }
            
            for data in receivedData {
                print(data)
            }
            
            handler(user)
        }
    }
    
    public func uploadProfileImage(data: Data)
    {
        STORAGE_BASE.child("users/profileImage/\((Auth.auth().currentUser?.uid)!).png").putData(data, metadata: nil) {
            (data, errors) in
            
            if errors != nil {
                return
            }
            
            let image: Dictionary<String, Any> = [
                "profileImage": (data?.downloadURL()?.absoluteString)!
            ]
            
            self.REF_USERS.child((Auth.auth().currentUser?.uid)!).updateChildValues(image)
        }
    }
    
    public func createPath(id: String, distance: Any, duration: Int16, altitude: Double)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM, YYYY HH:mm"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+2:00")
        
        let date = Date()
        let formattedDate = dateFormatter.string(from: date)
        
        let data = [
            "user": Auth.auth().currentUser?.uid,
            "distance": distance,
            "duration": duration,
            "altitude": altitude,
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
                    let id = data.childSnapshot(forPath: "id").value as! String
                    let altitude = data.childSnapshot(forPath: "altitude").value as! Double
                    let favorite = data.childSnapshot(forPath: "favorite").value as! Bool
                    
                    let path = Paths(distance: distance, duration: duration, date: date, altitude: altitude, id: id, favorite: favorite)
                    
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
    
    func deletePath(identifier: String)
    {
        REF_PATHS.observeSingleEvent(of: .value) { (dataSnapshot) in
            guard let receivedData = dataSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for data in receivedData {
                if data.childSnapshot(forPath: "id").value as! String == identifier {
                    self.REF_PATHS.child(data.key).removeValue()
                }
            }
        }
    }
    
    func makeFavoritePath(identifier: String)
    {
        REF_PATHS.observeSingleEvent(of: .value) { (snapshot) in
            guard let receivedData = snapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for data in receivedData {
                if data.childSnapshot(forPath: "id").value as! String == identifier {
                    let values = [
                        "favorite": true
                    ]
                    
                    self.REF_PATHS.child(data.key).updateChildValues(values)
                }
            }
        }
    }
    
    public func createLocations(id: String, locations: [HomeLocationStruct.persist])
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
    
    public func getLocationsByPath(identifier: String, handler: @escaping (_: [Locations]) -> ())
    {
        REF_LOCATIONS.observeSingleEvent(of: DataEventType.value) { (receivedData) in
            var locationsLists = [Locations]()
            
            guard let receivedLocations = receivedData.children.allObjects as? [DataSnapshot] else { return }
            
            for data in receivedLocations {
                
                if data.childSnapshot(forPath: "id").value as! String == identifier {
                    
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
    
    func deleteLocationsByPath(identifier: String)
    {
        REF_LOCATIONS.observeSingleEvent(of: .value) { (snapshot) in
            guard let receivedData = snapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for data in receivedData {
                if data.childSnapshot(forPath: "id").value as! String == identifier {
                    self.REF_LOCATIONS.child(data.key).removeValue()
                }
            }
        }
    }
}
