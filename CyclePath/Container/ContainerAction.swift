//
//  ContainerAction.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 28/09/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

import UIKit
import QuartzCore

enum SlideOutState
{
    case collapsed
    case leftSideExpanded
}

class ContainerAction: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

private extension UIStoryboard
{
    class func returnStoryboard() -> UIStoryboard
    {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    class func sideMenuAction() -> SideMenuAction?
    {
        return returnStoryboard().instantiateViewController(withIdentifier: "SideMenuAction") as? SideMenuAction
    }
    
    class func homeAction() -> HomeAction?
    {
        return returnStoryboard().instantiateViewController(withIdentifier: "HomeAction") as? HomeAction
    }
}
