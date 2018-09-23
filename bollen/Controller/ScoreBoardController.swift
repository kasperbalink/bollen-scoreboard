//
//  ScoreBoardController.swift
//  bollen
//
//  Created by Kasper Balink on 22/09/2018.
//  Copyright © 2018 Kasper Balink. All rights reserved.
//

import Foundation

let sharedScoreBoardController = ScoreBoardController()

class ScoreBoardController {
    var players: Array<Player> = []

    var playersIdx = 0;
    var lastPlayer = 0;
    var dealer = 0;
    var round: Int = 1;
    var roundsToBePlayed = 2
    
    var totalGuessed = 0;
    
    init() {
    }
    
    func setupLastPlayer(){
        lastPlayer = players.count - 1
        dealer = 0
    }
    
    func updateTotalGuesed(){
        totalGuessed = 0;
        for player in players {
            totalGuessed += player.guessedRounds
        }
        print("total:\(totalGuessed) - round:\(round) - last:\(lastPlayer)")
    }
    
    
    var countUp = true;
    func nextRound() {
        
        for player in players {
            if(player.finalRounds == player.guessedRounds) {
                player.score += 1
            }
        }
        
        if(round < roundsToBePlayed && countUp){
            round += 1
        }
        else {
            countUp = false
            round -= 1
        }
        
        lastPlayer += 1;
        if(lastPlayer > players.count - 1){
            lastPlayer = 0;
        }
        
        dealer += 1;
        if(dealer > players.count - 1){
            dealer = 0;
        }
        NotificationCenter.default.post(name: Notification.Name("guessedRoundsUpdate"), object: nil)
    }
}
