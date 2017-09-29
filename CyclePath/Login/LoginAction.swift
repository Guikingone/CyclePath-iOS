//
//  LoginAction.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 26/09/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

import UIKit

class LoginAction: UIViewController {

    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtLabel: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginUser(_ sender: Any)
    {
        guard let email = emailTxtField.text , emailTxtField.text != "" else { return }
        guard let password = passwordTxtLabel.text , passwordTxtLabel.text != "" else { return }
        
        LoginWorker().login(withEmail: email, withPassword: password) { (logged, errors) in
            if logged {
                self.performSegue(withIdentifier: "LoggedSegue", sender: self)
            } else {
                print(errors)
            }
        }
    }

}
