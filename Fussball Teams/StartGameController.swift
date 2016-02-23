//
//  StartGameController.swift
//  Fussball Teams
//
//  Created by Matei Suica on 23/02/16.
//  Copyright © 2016 Wirtek. All rights reserved.
//

import CoreData
import UIKit

class StartGameController  : UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var teamSizeSwitch: UISwitch!
    
    @IBOutlet weak var teamSizeLabel: UILabel!
    
    @IBOutlet weak var playersTable: UITableView!
    
    var players : [NSManagedObject] = []
    var selected : Set<Int> = []
    
    
    @IBAction func teamSizeSwitchAction(sender: AnyObject) {
        if teamSizeSwitch.on {
            teamSizeLabel.text = "2 vs 2"
        } else {
            teamSizeLabel.text = "1 vs 1"
        }
    }
    
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
        
        selected = []
    }
    
    
    @IBAction func startGameAction(sender: UIButton) {
      NSLog(String(selected))
        
        if (teamSizeSwitch.on && selected.count == 4) || (!teamSizeSwitch.on && selected.count == 2) {
               performSegueWithIdentifier("startGameSegue", sender: self)
        } else {
            let alert = UIAlertController(title: "Not fair", message: "Not enough players for the selected type of game", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        if teamSizeSwitch.on {
            if selected.count == 4 {
                return nil
            }
        } else {
            if selected.count == 2 {
                return nil;
            }
        }
        return indexPath
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let next = segue.destinationViewController as! GameDetailsController
        let game = Game()
        var array = Array(selected)
        
        var limit : Int
        if teamSizeSwitch.on {
            limit = 4
        } else {
            limit = 2
        }
        
        game.is2vs2 = teamSizeSwitch.on;
        
        for _ in 1...limit {
            array.shuffleInPlace()
            let obj = players[array.popLast()!]
            let player = Player()
            player.name = obj.valueForKey("name") as! String?
            
            game.players.append(player)
        }
    
        next.setGame(game)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            selected.insert(indexPath.row)
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        selected.remove(indexPath.row)
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

extension MutableCollectionType where Index == Int {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffleInPlace() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        
        for i in 0..<count - 1 {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}
