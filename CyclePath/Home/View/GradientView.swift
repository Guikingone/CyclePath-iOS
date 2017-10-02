//
//  GradientView.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 26/09/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

import UIKit

class GradientView: UIView
{
    let gradient = CAGradientLayer()
    
    override func awakeFromNib()
    {
        setUpGradientView()
    }
    
    public func setUpGradientView()
    {
        gradient.frame = self.bounds
        gradient.colors = [UIColor.white.cgColor, UIColor.init(white: 1.0, alpha: 0.0).cgColor]
        gradient.startPoint = CGPoint.zero
        gradient.endPoint = CGPoint(x: 0, y: 1)
        gradient.locations = [0.8, 1.0]
        
        self.layer.addSublayer(gradient)
    }
}
