//
//  PathsRouter.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 04/10/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

import UIKit

class PathsRouter
{
    weak var viewController: UIViewController!
    
    func showPathsDetails(segue: UIStoryboardSegue)
    {
        if let pathsDetailsAction = segue.destination as? PathsDetailsAction {
            pathsDetailsAction.path = (segue as? Paths)!
        }
    }
}
