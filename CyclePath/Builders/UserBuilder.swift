//
//  UserBuilder.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 07/11/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

import Foundation

class UserBuilder
{
    private(set) var user = User()
}

extension UserBuilder: UserBuilderProtocol
{
    func create() -> UserBuilder
    {
        self.user = User()
        
        return self
    }
    
    func withUsername(username: String) -> UserBuilder
    {
        self.user.setUsername(username: username)
        
        return self
    }
    
    func build() -> User
    {
        return self.user
    }
}
