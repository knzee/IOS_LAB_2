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
    
    var toast = Toast()
    
    var repository = Repository()
    
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
        let mail = mailTextField.text
        let password = passwordTextField.text

        if (!mail!.isEmpty && !password!.isEmpty) {
            
            if isEmailValid(email: mail!) {
                repository.login(email: mail!,password: password!)  { result in
                    if let _ = result as? Token {
                        self.presentTasksVC()
                    }
                    if let message = result as? String {
                        self.toast.popMessage(message: message, duration: 2.0, viewController: self)
                    }
                }
            } else {
                toast.popMessage(message: "Email is not valid", duration: 2.0, viewController: self)
            }
            
            
        } else {
            toast.popMessage(message: "You have empty fields", duration: 2.0, viewController: self)
         }

        
    }
    
    func isEmailValid(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func presentTasksVC() {
        let tasksVC = TasksVC()
        let nav = UINavigationController(rootViewController: tasksVC)
        
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
