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
    
    var apiService = APIService()
    var toast = Toast()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpButtons()
        setUpTextFields()
        
    }
    
    @IBAction func openRegisterVC(_ sender: Any) {
        let viewController = RegisterVC()
        
        self.present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func logIn(_ sender: Any) {
        /*let mail = mailTextField.text
        let password = passwordTextField.text

        if (!mail!.isEmpty && !password!.isEmpty) {
            
            apiService.login(email: mail!,password: password!)  { result in
                switch result {
                case .failure(let error):
                    self.toast.popMessage(message: "ASHIBOCHKA", duration: 2.0, viewController: self)
                    
                case .success(let value):
                    print(value.api_token)
                }
            }
            
        } else {
            toast.popMessage(message: "You have empty fields", duration: 2.0, viewController: self)
         }*/
        let notesVC = NotesVC()
        let nav = UINavigationController(rootViewController: notesVC)
        
        self.present(nav, animated: true, completion: nil)
        
    }
    
    func setUpTextFields() {
        mailTextField.addBottomBorder()
        passwordTextField.addBottomBorder()
    }
    
    func setUpButtons() {
        signInButton.setBorderRadius(radius: 8.0)
        signUpButton.setBorderRadius(radius: 8.0)
    }

}
