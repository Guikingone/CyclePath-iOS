//
//  ProfileAction.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 29/09/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

import UIKit
import Firebase

class ProfileAction: UIViewController
{
    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var profileImage: UIView!
    @IBOutlet weak var loggedOutTxt: UILabel!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var orTxtLabel: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if Auth.auth().currentUser == nil {
            logoutBtn.isHidden = true
            profileImage.isHidden = true
            loggedOutTxt.isHidden = false
            registerBtn.isHidden = false
            orTxtLabel.isHidden = false
            loginBtn.isHidden = false
        } else {
            logoutBtn.isHidden = false
            profileImage.isHidden = false
            loggedOutTxt.isHidden = true
            registerBtn.isHidden = true
            orTxtLabel.isHidden = true
            loginBtn.isHidden = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if Auth.auth().currentUser == nil {
            logoutBtn.isHidden = true
            profileImage.isHidden = true
            loggedOutTxt.isHidden = false
            registerBtn.isHidden = false
            orTxtLabel.isHidden = false
            loginBtn.isHidden = false
        } else {
            logoutBtn.isHidden = false
            profileImage.isHidden = false
            loggedOutTxt.isHidden = true
            registerBtn.isHidden = true
            orTxtLabel.isHidden = true
            loginBtn.isHidden = true
        }
        
    }
    @IBAction func registerUser(_ sender: Any)
    {
        self.performSegue(withIdentifier: "registerSegue", sender: self)
    }
    
    @IBAction func loginUser(_ sender: Any)
    {
        self.performSegue(withIdentifier: "loginSegue", sender: self)
    }
    
    @IBAction func LogoutUser(_ sender: Any)
    {
        let logoutPopUp = UIAlertController(
            title: "Logout ?",
            message: "Are you sure ?",
            preferredStyle: .actionSheet
        )
        
        let logoutAction = UIAlertAction(title: "Logout", style: .destructive) { (buttonTaped) in
            do {
                try Auth.auth().signOut()
                self.viewWillAppear(true)
            } catch {
                print(error)
            }
        }
        logoutPopUp.addAction(logoutAction)
        present(logoutPopUp, animated: true, completion: nil)
    }
}

extension ProfileAction: ProfileActionProtocol
{
    func checkAuth()
    {
        
    }
}
