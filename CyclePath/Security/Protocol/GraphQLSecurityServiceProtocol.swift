//
//  GraphQLSecurityServiceProtocol.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 07/11/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

protocol GraphQLSecurityServiceProtocol
{
    func registerUser(username: String, email: String, password: String, success: @escaping (_: Bool) -> (), failure: @escaping (_: Bool) -> ())
    
    func loginUser(email: String, password: String, success: @escaping (_: Bool) -> (), failure: @escaping (_: Bool)-> ())
}
