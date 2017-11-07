//
//  GraphQLSecurityService.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 07/11/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

import Foundation

class GraphQLSecurityService
{
    
}

extension GraphQLSecurityService: GraphQLSecurityServiceProtocol
{
    func registerUser(username: String, email: String, password: String, success: @escaping (_: Bool) -> (), failure: @escaping (_: Bool)-> ())
    {
        GraphQLFactory
            .instance
            .getClient(url: developmentGraphQLUrl)
            .perform(mutation: RegisterUserMutation(username: username, email: email, password: password)) {
                (data, errors) in
                
                if errors != nil {
                    print(errors?.localizedDescription as String!)
                    failure(true)
                }
                
                success(true)
        }
    }
    
    func loginUser(email: String, password: String, success: @escaping (_: Bool) -> (), failure: @escaping (_: Bool)-> ())
    {
        GraphQLFactory
            .instance
            .getClient(url: developmentGraphQLUrl)
            .perform(mutation: LoginUserMutation(email: email, password: password)) {
                (data, errors) in
                
                if errors != nil {
                    print(errors?.localizedDescription as String!)
                    failure(true)
                }
                
                // TODO : Handle data and store it.
                
                success(true)
        }
    }
}
