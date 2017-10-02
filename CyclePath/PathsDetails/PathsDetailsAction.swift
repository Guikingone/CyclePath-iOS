//
//  PathsDetailsAction.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 02/10/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

import UIKit

class PathsDetailsAction: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtn(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
}

extension PathsDetailsAction: PathsDetailsProtocol
{
    func displayInformations()
    {
        
    }
}
