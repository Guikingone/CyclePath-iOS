//
//  PathsAction.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 29/09/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

import UIKit
import Firebase

class PathsAction: UIViewController
{
    @IBOutlet weak var pathsList: UITableView!
    @IBOutlet weak var infoLbl: UILabel!
    
    private var pathsArray = [Paths]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        pathsList.delegate = self
        pathsList.dataSource = self
        
        checkAuth()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        checkAuth()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DataService.instance.getPathsByUser { (receivedData) in
            
            self.pathsArray = receivedData
            
            if self.pathsArray.count > 0 {
                self.pathsList.isHidden = false
            }
            
            self.pathsList.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // TODO: Pass data into the PathsDetailAction.
    }
}

extension PathsAction: PathsActionProtocol
{
    func checkAuth()
    {
        if Auth.auth().currentUser == nil {
            pathsList.isHidden = true
            infoLbl.isHidden = false
            infoLbl.text = "You must be logged in order to see your saved paths."
        } else {
            if pathsArray.count < 1 {
                infoLbl.isHidden = false
                pathsList.isHidden = true
            } else {
                infoLbl.isHidden = true
            }
        }
    }
}

extension PathsAction: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return pathsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = pathsList.dequeueReusableCell(withIdentifier: "PathCell") as? PathsCell else { return UITableViewCell() }
        let path = pathsArray[indexPath.row]
        
        cell.configureCell(data: path)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.performSegue(withIdentifier: "PathDetailsSegue", sender: self)
    }
}
