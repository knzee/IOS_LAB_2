//
//  RegisterVC.swift
//  Lab2
//
//  Created by Test Testovich on 09/04/2020.
//  Copyright © 2020 TSU. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {

    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatTextField: UITextField!
    

    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpButtons()
        setUpTextFields()
        
    }
    
    @IBAction func openLoginVC(_ sender: Any) {
        let viewController = LoginVC()
        
        self.present(viewController, animated: true, completion: nil)
    }
    
    func setUpButtons() {
        signInButton.layer.cornerRadius = 8.0
        registerButton.layer.cornerRadius = 8.0
        
    }
    
    func setUpTextFields() {
        mailTextField.addBottomBorder()
        passwordTextField.addBottomBorder()
        repeatTextField.addBottomBorder()
        nameTextField.addBottomBorder()
    }

}
