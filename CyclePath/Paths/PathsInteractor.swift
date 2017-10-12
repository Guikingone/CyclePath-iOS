//
//  PathsInteractor.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 02/10/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

class PathsInteractor
{
    
}

extension PathsInteractor: PathsInteractorProtocol
{
    func removePath(identifier: String)
    {
        DataService.instance.deletePath(identifier: identifier)
    }
    
    func removeLocationsLinkedToPath(identifier: String)
    {
        DataService.instance.deleteLocationsByPath(identifier: identifier)
    }
    
    func makeFavoritePath(identifier: String)
    {
        DataService.instance.makeFavoritePath(identifier: identifier)
    }
}

