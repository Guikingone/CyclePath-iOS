//
//  PathsAction.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 29/09/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

import UIKit
import Firebase

class PathsAction: UIViewController {

    @IBOutlet weak var lastPathCard: UIView!
    @IBOutlet weak var pathsList: UITableView!
    @IBOutlet weak var noPathsTxt: UILabel!
    @IBOutlet weak var authTxt: UILabel!
    
    private var pathsArray: [String: Any] = [:]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        checkAuth()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        checkAuth()
    }
}

extension PathsAction: PathsActionProtocol
{
    func displayPaths()
    {
        
    }
    
    func reloadPaths()
    {
        
    }
    
    func checkAuth()
    {
        if Auth.auth().currentUser == nil {
            lastPathCard.isHidden = true
            pathsList.isHidden = true
            noPathsTxt.isHidden = true
            authTxt.isHidden = false
        } else {
            if pathsArray.count < 1 {
                authTxt.isHidden = true
                pathsList.isHidden = true
                noPathsTxt.isHidden = false
            }
        }
    }
}
