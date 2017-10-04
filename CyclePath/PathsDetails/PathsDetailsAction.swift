//
//  PathsDetailsAction.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 02/10/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

import UIKit
import MapKit

class PathsDetailsAction: UIViewController
{
    var paths = [Paths]()
    @IBOutlet weak var pathDateLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var averageAltimeterLbl: UILabel!
    @IBOutlet weak var averageRythm: UILabel!
    @IBOutlet weak var mapViewDetails: MKMapView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        displayInformations()
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
        for path in paths {
            pathDateLbl.text = "Path of \(path.formattedTimestamp)"
            distanceLbl.text = "\(String(describing: path.formattedDistance)) meters"
            averageRythm.text = "\(path.formattedDuration)"
            averageAltimeterLbl.text = ""
        }
    }
}

extension PathsDetailsAction: MKMapViewDelegate
{
    
}
