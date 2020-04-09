//
//  LoginVC.swift
//  Lab2
//
//  Created by Test Testovich on 08/04/2020.
//  Copyright © 2020 TSU. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpButtons()
        setUpTextFields()
        
    }
    
    @IBAction func openRegisterVC(_ sender: Any) {
        let viewController = RegisterVC()
        
        self.present(viewController, animated: true, completion: nil)
    }
    
    func setUpTextFields() {
        mailTextField.addBottomBorder()
        passwordTextField.addBottomBorder()
    }
    
    func setUpButtons() {
        signInButton.layer.cornerRadius = 8.0
        signUpButton.layer.cornerRadius = 8.0
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
