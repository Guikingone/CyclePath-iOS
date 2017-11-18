//
//  RegisterWorkProtocol.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 08/11/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

protocol RegisterWorkerProtocol
{
    func registerUser(registerStruct: RegisterStruct, status: @escaping (_: Bool) -> ())
}
