//
//  Toast.swift
//  Lab2
//
//  Created by Test Testovich on 10/04/2020.
//  Copyright © 2020 TSU. All rights reserved.
//

import UIKit

class Toast {
    
    func popMessage(message: String, duration: Double, viewController: UIViewController) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: UIAlertController.Style.alert)
        
        viewController.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
}
