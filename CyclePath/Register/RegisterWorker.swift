//
//  RegisterWorker.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 29/09/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

import Foundation
import Firebase

class RegisterWorker
{
    func register(withUsername username: String, withEmail email: String, withPassword password: String, userCreated: @escaping (_ success: Bool, _ errors: Error?) -> ())
    {
        Auth.auth().createUser(withEmail: email, password: password) { (user, errors) in
            guard let user  = user else {
                userCreated(false, errors)
                return
            }
            
            let userData = [
                "provider": user.providerID,
                "username": username,
                "email": user.email
            ]
            
            DataService.instance.createUser(uid: user.uid, data: userData)
            
            userCreated(true, nil)
        }
    }
}

extension RegisterWorker: RegisterWorkerProtocol
{
    func registerUser(registerStruct: RegisterStruct, status: @escaping (_: Bool) -> ()) {
        GraphQLSecurityService().registerUser(registerStruct: registerStruct, success: { (saved) in
            status(true)
        }) { (failed) in
            status(false)
        }
    }
}
