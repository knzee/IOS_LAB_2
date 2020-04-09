//
//  RoundedButton.swift
//  Lab2
//
//  Created by Test Testovich on 08/04/2020.
//  Copyright © 2020 TSU. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 25
    }
}
