//
//  ScoreBoardViewController.swift
//  bollen
//
//  Created by Kasper Balink on 17/09/2018.
//  Copyright © 2018 Kasper Balink. All rights reserved.
//

import UIKit

class ScoreBoardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var startRound : UIButton!
    @IBOutlet var nextRound : UIButton!
    @IBOutlet var scoreboardTableView: UITableView!
    var scoreboard : ScoreBoardController = sharedScoreBoardController;
    var finishGame = false
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreboard.setupLastPlayer()
        scoreboardTableView.allowsSelection = false
        scoreboardTableView.delegate = self
        scoreboardTableView.dataSource = self
        self.title = "Round \(scoreboard.currentCards)/\(scoreboard.roundsToBePlayed)"
        NotificationCenter.default.addObserver(self, selector: #selector(self.otherPlayerUpdatedGuessedRounds(notification:)), name: Notification.Name("guessedRoundsUpdate"), object: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func otherPlayerUpdatedGuessedRounds(notification: Notification){
        scoreboardTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoreboard.players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreBoardCell", for: indexPath) as! ScoreBoardTableViewCell
        let row = indexPath.row
        cell.player = scoreboard.players[row]
        if(row == scoreboard.lastPlayer) {
            cell.player.last = true;
        }
        else {
            cell.player.last = false;
        }
        if(row == scoreboard.dealer) {
            cell.player.dealer = true;
        }
        else {
            cell.player.dealer = false;
        }
        cell.setValue()
        return cell;
    }
    
    @IBAction func startRoundButtonClick(_ sender: UIButton){
        let cells = self.scoreboardTableView.visibleCells as! Array<ScoreBoardTableViewCell>
      
        for cell in cells {
            cell.guessedRoundsButton.isEnabled = false
            cell.finalRoundsButton.isEnabled = true
            cell.guessedRoundsButton.backgroundColor = UIColor(red: 231/255, green:129/255, blue:132/255, alpha:0.42)
            cell.finalRoundsButton.backgroundColor = UIColor(red: 213/255, green:62/255, blue:53/255, alpha:1)
        }
        
        if(scoreboard.currentCards == 1 && !scoreboard.countUp){
            finishGame = true
            nextRound.setTitle("Finish game", for: UIControlState.normal)
        }
        nextRound.isHidden = false;
        startRound.isHidden = true;
        scoreboardTableView.reloadData();
    }
    
    @IBAction func nextRoundButtonClick(_ sender: UIButton) {
        if(finishGame){
            
        }
        
        let cells = self.scoreboardTableView.visibleCells as! Array<ScoreBoardTableViewCell>
        
        scoreboard.nextRound()
        
        for cell in cells {
            cell.finalRoundsButton.setTitle("0", for: .normal);
            cell.guessedRoundsButton.setTitle("0", for: .normal);
            cell.guessedRoundsButton.isEnabled = true
            cell.player.guessedRounds = 0
            cell.finalRoundsButton.isEnabled = false
            cell.player.finalRounds = 0
            cell.guessedRoundsButton.backgroundColor = UIColor(red: 213/255, green:62/255, blue:53/255, alpha:1)
            cell.finalRoundsButton.backgroundColor = UIColor(red: 231/255, green:129/255, blue:132/255, alpha:0.42)
        }

        self.title = "Round \(scoreboard.currentRound)/\(scoreboard.roundsToBePlayed)"
        
        nextRound.isHidden = true;
        startRound.isHidden = false;
        
        scoreboardTableView.reloadData();
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
