//
//  LoginAction.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 26/09/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

import UIKit

class LoginAction: UIViewController
{
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtLabel: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Input gesture
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))

        // Do any additional setup after loading the view.
    }
    
    @IBAction func back(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loginUser(_ sender: Any)
    {
        guard let email = emailTxtField.text , emailTxtField.text != "" else { return }
        guard let password = passwordTxtLabel.text , passwordTxtLabel.text != "" else { return }
        
        LoginWorker().login(withEmail: email, withPassword: password) { (logged, errors) in
            if logged {
                self.dismiss(animated: true, completion: nil)
            } else {
                print("Could not log the user : \(String(describing: errors?.localizedDescription))")
            }
        }
    }
    
    @IBAction func forgotPassword(_ sender: Any)
    {
        self.performSegue(withIdentifier: "ForgotPasswordSegue", sender: self)
    }
}
