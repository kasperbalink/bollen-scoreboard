//
//  SelectRoundsView.swift
//  bollen
//
//  Created by Kasper Balink on 19/09/2018.
//  Copyright © 2018 Kasper Balink. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {
    @IBInspectable var cornerRadius : CGFloat = 0.0
    
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = cornerRadius
    }
}
