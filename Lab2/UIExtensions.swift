//
//  UIExtensions.swift
//  Lab2
//
//  Created by Test Testovich on 09/04/2020.
//  Copyright © 2020 TSU. All rights reserved.
//

import UIKit

extension UITextField {
    func addBottomBorder() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.gray.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
}
