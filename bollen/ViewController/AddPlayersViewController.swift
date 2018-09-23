//
//  AddPlayersViewController.swift
//  bollen
//
//  Created by Kasper Balink on 12/09/2018.
//  Copyright © 2018 Kasper Balink. All rights reserved.
//
import Foundation
import UIKit

class AddPlayersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{

    @IBOutlet var playersTabelView: UITableView!
    var players: Array<String> = []
    private var addedPlayer = 1;
    private var selectedRow = 0;
    override func viewDidLoad() {
        super.viewDidLoad()
        self.playersTabelView.delegate = self
        self.playersTabelView.dataSource = self
        self.playersTabelView.sectionIndexColor = UIColor.clear
        self.playersTabelView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        self.playersTabelView.rowHeight = UITableViewAutomaticDimension

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    @IBAction func AddPlayerButton_Click(_ sender: UIButton) {
        if(players.count < 8) {
            players.append("Player \(addedPlayer)")
            addedPlayer += 1
            playersTabelView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        var newPlayers : Array<Player> = []
        for name in players {
            newPlayers.append(Player(name: name))
        }
        sharedScoreBoardController.players = newPlayers;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.players.count
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayersTableViewCell", for: indexPath) as! PlayersTableViewCell
        let row = indexPath.section
        cell.playersLabel.text = players[row]
        return cell;
    }
    
    func showAlert(){
        let alert = UIAlertController(title: "Name", message:"Enter the name of the player", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Add", style: UIAlertActionStyle.default, handler: nil))
        alert.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.placeholder = ""
            textField.delegate = self
        })
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.playersTabelView.deselectRow(at: indexPath, animated: false)
        self.selectedRow = indexPath.section;
        showAlert();
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.players[self.selectedRow] = textField.text!
        playersTabelView.reloadData();
    }
}
