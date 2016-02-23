//
//  PlayerDetailsController.swift
//  Fussball Teams
//
//  Created by Matei Suica on 23/02/16.
//  Copyright © 2016 Wirtek. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class PlayerDetailsController : UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var playerName: UITextField!
    
    @IBAction func saveData(sender: AnyObject) {
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let entity =  NSEntityDescription.entityForName("Player",
            inManagedObjectContext:managedContext)
        
        let player = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext: managedContext)
        
        player.setValue(playerName.text!, forKey: "name")

        do {
            try managedContext.save()
            navigationController?.popViewControllerAnimated(true)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.playerName.delegate = self
    }
    
    func textFieldShouldReturn(userText: UITextField) -> Bool {
        userText.resignFirstResponder()
        return true;
    }
}