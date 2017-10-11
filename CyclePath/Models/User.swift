//
//  User.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 11/10/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

import Foundation

class User
{
    private var username: String = ""
    private var email: String = ""
    
    var getUsername: String {
        return username
    }
    
    var getEmail: String {
        return email
    }
    
    func setUsername(username: String) {
        self.username = username
    }
    
    func setEmail(email: String) {
        self.email = email
    }
}
