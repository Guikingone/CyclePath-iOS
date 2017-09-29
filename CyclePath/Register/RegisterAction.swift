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
        
        usernameTxtLabel.delegate = self
        emailTextLabel.delegate = self
        passwordTxtLabel.delegate = self
        passwordRptTxtLabel.delegate = self
    }

    @IBAction func registerUser(_ sender: Any)
    {
        guard let username = usernameTxtLabel.text , usernameTxtLabel.text != "" else { return }
        guard let email = emailTextLabel.text , emailTextLabel.text != "" else { return }
        guard let password = passwordTxtLabel.text , passwordTxtLabel.text != "" else { return }
        guard let passwordRpt = passwordRptTxtLabel.text , passwordRptTxtLabel.text == password else { return }
        
        RegisterWorker().register(withUsername: username, withEmail: email, withPassword: passwordRpt) { (created, errors) in
            if created {
                self.performSegue(withIdentifier: "RegisterSegue", sender: self)
            } else {
                print(errors)
            }
        }
    }
}

extension RegisterAction: UITextFieldDelegate
{
    
}
