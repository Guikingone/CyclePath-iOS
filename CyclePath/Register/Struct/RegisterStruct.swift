//
//  RegisterStruct.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 18/11/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

struct RegisterStruct
{    
    let username: String
    let email: String
    let password: String
    
    func getUsername() -> String {
        return username
    }
    
    func getEmail() -> String {
        return email
    }
    
    func getPassword() -> String {
        return password
    }
}
