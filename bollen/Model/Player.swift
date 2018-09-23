//
//  Player.swift
//  bollen
//
//  Created by Kasper Balink on 12/09/2018.
//  Copyright © 2018 Kasper Balink. All rights reserved.
//

import Foundation
import UIKit

public class Player {
    var id : guid_t = guid_t()
    var name : String = ""
    var guessedRounds : Int = 0
    var finalRounds : Int = 0
    var score : Int = 0
    var last : Bool = false
    var dealer : Bool = false
    
    init(name : String){
    self.name = name
    }
    
}
