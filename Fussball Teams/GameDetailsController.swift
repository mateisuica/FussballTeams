//
//  GameDetailsController.swift
//  Fussball Teams
//
//  Created by Matei Suica on 23/02/16.
//  Copyright © 2016 Wirtek. All rights reserved.
//

import CoreData
import UIKit

class GameDetailsController  : UIViewController {

    @IBOutlet weak var team1attackLabel: UILabel!
    @IBOutlet weak var team1defenceLabel: UILabel!
    @IBOutlet weak var team2attackLabel: UILabel!
    @IBOutlet weak var team2defenceLabel: UILabel!
    
    
    @IBOutlet weak var team1attackPlayer: UILabel!
    @IBOutlet weak var team1defencePlayer: UILabel!
    @IBOutlet weak var team2attackPlayer: UILabel!
    @IBOutlet weak var team2defencePlayer: UILabel!
    
    
    var game : Game?
    
    func setGame(game : Game) {
        self.game = game;
    }
    
    override func viewWillAppear(animated: Bool) {
        if let is2vs2 = game?.is2vs2 {
            if is2vs2 {
                team1attackLabel.hidden = false
                team1defenceLabel.hidden = false
                team2attackLabel.hidden = false
                team2defenceLabel.hidden = false
                
                team1attackPlayer.hidden = false
                team1defencePlayer.hidden = false
                team2attackPlayer.hidden = false
                team2defencePlayer.hidden = false
                
                
                team1attackPlayer.text = game?.players.popLast()?.name
                team1defencePlayer.text = game?.players.popLast()?.name
                team2attackPlayer.text = game?.players.popLast()?.name
                team2defencePlayer.text = game?.players.popLast()?.name

                
                
            } else {
                team1attackLabel.hidden = false
                team1defenceLabel.hidden = true
                team2attackLabel.hidden = false
                team2defenceLabel.hidden = true
                
                team1attackPlayer.hidden = false
                team1defencePlayer.hidden = true
                team2attackPlayer.hidden = false
                team2defencePlayer.hidden = true
                
                team1attackPlayer.text = game?.players.popLast()?.name
                team2attackPlayer.text = game?.players.popLast()?.name
            }
        }
    }
    
}