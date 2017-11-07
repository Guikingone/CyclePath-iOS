//
//  GraphQLFactory.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 07/11/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

import Apollo
import Foundation

class GraphQLFactory
{
    static let instance = GraphQLFactory()
}

extension GraphQLFactory: GraphQLFactoryProtocol
{
    func getClient(url: String) -> ApolloClient
    {
        return ApolloClient(url: URL(string: url)!)
    }
}
