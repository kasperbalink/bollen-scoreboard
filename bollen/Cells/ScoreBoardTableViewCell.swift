//
//  ScoreBoardTableViewCell.swift
//  bollen
//
//  Created by Kasper Balink on 17/09/2018.
//  Copyright © 2018 Kasper Balink. All rights reserved.
//

import UIKit

class ScoreBoardTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet var finalRoundsButton: UIButton!
    @IBOutlet var guessedRoundsButton: UIButton!
    @IBOutlet var playerInitial: UILabel!
    @IBOutlet var score: UILabel!
    @IBOutlet var dealerLastLabel: UILabel!
    @IBOutlet var content: UIView!
    var player : Player!


    
    override func awakeFromNib() {
        super.awakeFromNib()
        content.layer.cornerRadius = 20
        NotificationCenter.default.addObserver(self, selector: #selector(self.otherPlayerUpdatedGuessedRounds(notification:)), name: Notification.Name("guessedRoundsUpdate"), object: nil)
        finalRoundsButton.isEnabled = false
    }
    
    @objc func otherPlayerUpdatedGuessedRounds(notification: Notification){
        let scoreboard = sharedScoreBoardController;
        if(player.last && scoreboard.totalGuessed == scoreboard.currentCards)
        {
            player.guessedRounds += 1;
            if(player.guessedRounds > scoreboard.currentCards){
                player.guessedRounds = 0
            }
            //print("UPDATE: \(player.guessedRounds) for \(player.name)");
            scoreboard.updateTotalGuesed()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("guessedRoundsUpdate"), object: nil)
    }
    
    func setValue() {
        playerInitial.text = player.name
        guessedRoundsButton.setTitle(String(player.guessedRounds), for: .normal)
        score.text = String(player.score);
        if(player.dealer){
            dealerLastLabel.backgroundColor = UIColor(red: 143/255, green: 188/255, blue: 143/255, alpha: 1);
        } else if (player.last) {
        dealerLastLabel.backgroundColor = UIColor(red: 51/255, green: 121/255, blue: 188/255, alpha: 1);
        } else {
            dealerLastLabel.backgroundColor = UIColor.clear;
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    
    @IBAction func guessedRoundsButtonClick(_ sender: UIButton) {
        let scoreboard = sharedScoreBoardController;

        player.guessedRounds += 1;
        if(player.guessedRounds > scoreboard.currentCards){
            player.guessedRounds = 0
        }
        scoreboard.updateTotalGuesed();
        
        if(player.last && scoreboard.currentCards == scoreboard.totalGuessed){
            player.guessedRounds += 1;
            if(player.guessedRounds > scoreboard.currentCards){
                player.guessedRounds = 0
            }
            scoreboard.updateTotalGuesed()
        }
        NotificationCenter.default.post(name: Notification.Name("guessedRoundsUpdate"), object: nil)
        guessedRoundsButton.setTitle(String(player.guessedRounds), for: .normal)
    }
    
    @IBAction func finalRoundsButtonClick(_ sender: UIButton) {
        let scoreboard = sharedScoreBoardController;
        player.finalRounds += 1;
        scoreboard.finalRounds += 1
        let oldValue = player.finalRounds;
        if(player.finalRounds > scoreboard.currentCards || scoreboard.finalRounds > scoreboard.currentCards){
            player.finalRounds = 0
        }
        if(player.finalRounds == 0){
            scoreboard.finalRounds -= oldValue;
        }
        
        print("final: \(scoreboard.finalRounds)")
      
        finalRoundsButton.setTitle(String(player.finalRounds), for: .normal)
    }
    
}
