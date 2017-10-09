//
//  ProfileWorker.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 06/10/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

import UIKit
import Foundation

class ProfileWorker
{
    func uploadImage(data: Data)
    {
        DataService.instance.uploadProfileImage(data: data)
    }
    
    func downloadProfileImage(imageHandler: @escaping (_: UIImage) -> ())
    {
        
    }
}
