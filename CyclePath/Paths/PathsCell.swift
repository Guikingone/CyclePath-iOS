//
//  PathsCell.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 02/10/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

import Foundation

class PathsCell: UITableViewCell
{
    private var distance: Int = 0
    private var duration: Int16 = 0
    private var timestamp: String = ""
    
    func configureCell(data: Paths)
    {
        distance = data.formattedDistance
        duration = data.formattedDuration
        timestamp = data.formattedTimestamp
    }
}
