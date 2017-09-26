//
//  ProfileImage.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 26/09/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

import UIKit

class ProfileImage: UIImageView
{
    override func awakeFromNib()
    {
        setUpView()
    }
    
    public func setUpView()
    {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
}
