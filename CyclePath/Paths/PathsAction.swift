//
//  PathsAction.swift
//  CyclePath
//
//  Created by Guillaume Loulier on 29/09/2017.
//  Copyright © 2017 Guillaume Loulier. All rights reserved.
//

import UIKit
import Firebase

class PathsAction: UIViewController {

    @IBOutlet weak var lastPathCard: UIView!
    @IBOutlet weak var pathsList: UITableView!
    @IBOutlet weak var noPathsTxt: UILabel!
    @IBOutlet weak var authTxt: UILabel!
    
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
        
        DataService.instance.getPathsByUser()
        
        checkAuth()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        pathsArray = DataService.instance.getPaths
        pathsList.reloadData()
        
        if pathsArray.count > 0 {
            noPathsTxt.isHidden = true
            pathsList.isHidden = false
        }
    }
}

extension PathsAction: PathsActionProtocol
{
    func displayPaths()
    {
        
    }
    
    func reloadPaths()
    {
        
    }
    
    func checkAuth()
    {
        if Auth.auth().currentUser == nil {
            lastPathCard.isHidden = true
            pathsList.isHidden = true
            noPathsTxt.isHidden = true
            authTxt.isHidden = false
        } else {
            if pathsArray.count < 1 {
                authTxt.isHidden = true
                pathsList.isHidden = true
                noPathsTxt.isHidden = false
            }
        }
    }
}

extension PathsAction: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pathsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = pathsList.dequeueReusableCell(withIdentifier: "PathsCell") as? PathsCell else { return UITableViewCell() }
        let path = pathsArray[indexPath.row]
        
        cell.configureCell(data: path)
        return cell
    }
}
