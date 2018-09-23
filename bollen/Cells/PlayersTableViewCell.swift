//
//  PlayersTableViewCell.swift
//  bollen
//
//  Created by Kasper Balink on 14/09/2018.
//  Copyright © 2018 Kasper Balink. All rights reserved.
//

import UIKit

class PlayersTableViewCell: UITableViewCell {

    
    @IBOutlet var content: UIView!
    @IBOutlet var playersLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        content.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
        content.layer.borderWidth = 1
        content.layer.cornerRadius = 5
        self.layoutMargins = UIEdgeInsets(top: 15, left: 5, bottom: 15, right: 5)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}
