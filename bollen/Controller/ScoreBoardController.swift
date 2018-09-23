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

    var lastPlayer = 0;
    var dealer = 0;
    
    var currentCards = 1;
    let maxCards = 6;
    let roundsToBePlayed = 12
    var currentRound = 1;
    
    var totalGuessed = 0;
    var finalRounds = 0;
    
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
        if(finalRounds != currentRound) {
            return
        }
        
        for player in players {
            if(player.finalRounds == player.guessedRounds) {
                player.score += 1
            }
            player.finalRounds = 0
            player.guessedRounds = 0
        }
        
        if(currentCards < maxCards && countUp){
            currentCards += 1
        }
        else {
            countUp = false
            currentCards -= 1
        }
        
        lastPlayer += 1;
        if(lastPlayer > players.count - 1){
            lastPlayer = 0;
        }
        
        dealer += 1;
        if(dealer > players.count - 1){
            dealer = 0;
        }
        
        currentRound += 1
        finalRounds = 0;
        NotificationCenter.default.post(name: Notification.Name("guessedRoundsUpdate"), object: nil)
    }
}
