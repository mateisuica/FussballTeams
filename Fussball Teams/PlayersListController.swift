//
//  PlayersListController.swift
//  Fussball Teams
//
//  Created by Matei Suica on 23/02/16.
//  Copyright © 2016 Wirtek. All rights reserved.
//
import Foundation
import UIKit
import CoreData

class PlayersListController : UIViewController, UITableViewDataSource {
    
    
    @IBOutlet weak var playersTable: UITableView!
    
    var players : [NSManagedObject] = []

    override func viewWillAppear(animated: Bool) {
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        

        let fetchRequest = NSFetchRequest(entityName: "Player")
        
        //3
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            players = results as! [NSManagedObject]
            playersTable!.reloadData()
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return players.count
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
            
            let cell =
            tableView.dequeueReusableCellWithIdentifier("playernamecell") as! PlayerTableCell
            
            let cellContent = players[indexPath.row];
            cell.playerNameLabel!.text = cellContent.valueForKey("name") as? String
            
            return cell
    }
}