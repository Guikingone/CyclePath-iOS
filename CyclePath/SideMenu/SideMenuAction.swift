//
//  SideMenuAction.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 26/09/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

import UIKit
import Firebase

class SideMenuAction: UIViewController
{
    @IBOutlet weak var profileBtn: UIButton!
    @IBOutlet weak var pathsBtn: UIButton!
    @IBOutlet weak var settingsBtn: UIButton!
    @IBOutlet weak var helpBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if Auth.auth().currentUser == nil {
            profileBtn.isHidden = true
            pathsBtn.isHidden = true
            settingsBtn.isHidden = true
            helpBtn.isHidden = true
        } else {
            registerBtn.isHidden = true
            loginBtn.isHidden = true
        }
    }
    
    @IBAction func registerUser(_ sender: Any)
    {
        self.performSegue(withIdentifier: "RegisterSegue", sender: self)
    }
    
    @IBAction func loginUser(_ sender: Any)
    {
        self.performSegue(withIdentifier: "LoginSegue", sender: self)
    }
    
    @IBAction func userProfile(_ sender: Any)
    {
        self.performSegue(withIdentifier: "ProfileSegue", sender: self)
    }
    
    @IBAction func userPaths(_ sender: Any)
    {
        self.performSegue(withIdentifier: "PathsSegue", sender: self)
    }
}
