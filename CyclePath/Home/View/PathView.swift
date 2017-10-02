//
//  PathView.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 27/09/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

import UIKit

class PathView: UIView
{
    override func awakeFromNib()
    {
        setUpView()
    }
    
    public func setUpView()
    {
        self.layer.cornerRadius = 5.0
        self.layer.shadowRadius = 10.0
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize.zero
    }
}
