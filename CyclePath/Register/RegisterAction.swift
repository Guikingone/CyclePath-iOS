//
//  RegisterAction.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 26/09/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

import UIKit

class RegisterAction: UIViewController
{
    @IBOutlet weak var usernameTxtLabel: UITextField!
    @IBOutlet weak var emailTextLabel: UITextField!
    @IBOutlet weak var passwordTxtLabel: UITextField!
    @IBOutlet weak var passwordRptTxtLabel: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Input gesture
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        usernameTxtLabel.delegate = self
        emailTextLabel.delegate = self
        passwordTxtLabel.delegate = self
        passwordRptTxtLabel.delegate = self
    }
    
    @IBAction func back(_ sender: Any)
    {
        dismissDetails()
    }

    @IBAction func registerUser(_ sender: Any)
    {
        guard let username = usernameTxtLabel.text , usernameTxtLabel.text != "" else { return }
        guard let email = emailTextLabel.text , emailTextLabel.text != "" else { return }
        guard let password = passwordTxtLabel.text , passwordTxtLabel.text != "" else { return }
        guard let passwordRpt = passwordRptTxtLabel.text , passwordRptTxtLabel.text == password else { return }
        
        let registerStruct = RegisterStruct(username: username, email: email, password: passwordRpt)
        
        RegisterWorker().registerUser(registerStruct: registerStruct) { (saved) in
            if saved {
                self.performSegue(withIdentifier: "RegisteredSegue", sender: self)
            } else {
                print("Registration failure !")
            }
        }
    }
}

extension RegisterAction: UITextFieldDelegate
{
    
}
