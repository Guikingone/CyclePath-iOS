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
    
    func makeFavoritePath(data: Paths, handler: @escaping (_: Bool) -> ())
    {
        DataService.instance.makeFavoritePath(identifier: data.getId) { (success) in
            if success {
                handler(true)
            } else {
                handler(false)
            }
        }
    }
}

