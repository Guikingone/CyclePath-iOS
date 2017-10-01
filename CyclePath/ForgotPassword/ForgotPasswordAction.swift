//
//  ForgotPasswordAction.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 01/10/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

import UIKit
import Firebase

class ForgotPasswordAction: UIViewController
{
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var informationLbl: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Input gesture
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    @IBAction func resetPasswordRequest(_ sender: Any)
    {
        guard let email = emailTxtField.text , emailTxtField.text != "" else { return }
        
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error != nil {
                self.informationLbl.text = "An error has been detected : \(String(describing: error?.localizedDescription))"
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
