//
//  PathsCell.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 02/10/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

import Foundation
import UIKit

class PathsCell: UITableViewCell
{
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    
    func configureCell(data: Paths)
    {
        dateLbl.text = data.formattedDate
        distanceLbl.text = "\(data.transformMeters()) mètres"
    }
}
