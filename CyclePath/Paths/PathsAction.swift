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
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        DataService.instance.getPathsByUser { (receivedData) in
            
            self.pathsArray = receivedData
            
            if self.pathsArray.count >= 1 {
                self.pathsList.isHidden = false
                
                self.pathsList.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let pathDetailsAction = segue.destination as? PathsDetailsAction {
            pathDetailsAction.path = sender as! Paths
        }
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
    
    func loadPaths()
    {
        DataService.instance.getPathsByUser { (paths) in
            self.pathsArray = paths
            self.pathsList.reloadData()
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
        let values = pathsArray[indexPath.row]
        
        self.performSegue(withIdentifier: "PathDetailsSegue", sender: values)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, index) in
            let path = self.pathsArray[index.row]
            PathsInteractor().removePath(identifier: path.getId)
            self.pathsList.reloadData()
            // TODO : Remove the value from the paths array.
            tableView.deleteRows(at: [indexPath], with: .top)
        }
        
        let favoriteAction = UITableViewRowAction(style: .normal, title: "FAVORITE") { (rowAction, indexPath) in
            let values = self.pathsArray[indexPath.row]
            PathsInteractor().makeFavoritePath(data: values, handler: { (bool) in
                // TODO
            })
        }
        
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1592534781, blue: 0.184384346, alpha: 1)
        favoriteAction.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        
        return [deleteAction, favoriteAction]
    }
}
