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
    
    var toast: Toast = Toast()
    
    var repository = Repository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpButtons()
        setUpTextFields()
        
    }
    
    @IBAction func openLoginVC(_ sender: Any) {
        presentLoginVC()
    }
    
    func presentLoginVC(){
        let viewController = LoginVC()
        self.present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func Register(_ sender: Any) {
        let mail = mailTextField.text
        let name = nameTextField.text
        let password = passwordTextField.text
        let rptPass = repeatTextField.text
        
        if (!mail!.isEmpty && !name!.isEmpty && !password!.isEmpty && !rptPass!.isEmpty) {
            if isEmailValid(email: mail!) {
                
                if (password == rptPass) {
                    repository.register(email: mail!, name: name!, password: password!)  { result in
                        if result != nil {
                            self.presentLoginVC()
                        }
                    }
                } else {
                    toast.popMessage(message: "Passwords do not match", duration: 2.0, viewController: self)
                }
                
            } else {
                toast.popMessage(message: "Email is not vaild!", duration: 2.0, viewController: self)
            }
            
        } else {
            toast.popMessage(message: "You have empty fields",duration: 2.0, viewController: self)
        }
    }
    
    func isEmailValid(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func setUpButtons() {
        signInButton.setBorderRadius(radius: 8.0)
        registerButton.setBorderRadius(radius: 8.0)
    }
    
    func setUpTextFields() {
        mailTextField.addBottomBorder()
        passwordTextField.addBottomBorder()
        repeatTextField.addBottomBorder()
        nameTextField.addBottomBorder()
    }

}
