//
//  LoginWorker.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 29/09/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

import Foundation
import Firebase

class LoginWorker
{
    func login(withEmail email: String, withPassword password: String, userLogged: @escaping (_ success: Bool, _ errors: Error?) -> ())
    {
        Auth.auth().signIn(withEmail: email, password: password) { (user, errors) in

            if errors != nil {
                userLogged(false, errors)
                return
            }
            
            userLogged(true, nil)
        }
    }
}
