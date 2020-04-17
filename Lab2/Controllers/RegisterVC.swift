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
    
    var apiService: APIService = APIService()
    var toast: Toast = Toast()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpButtons()
        setUpTextFields()
        
    }
    
    @IBAction func openLoginVC(_ sender: Any) {
        let viewController = LoginVC()
        
        self.present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func Register(_ sender: Any) {
        let mail = mailTextField.text
        let name = nameTextField.text
        let password = passwordTextField.text
        let rptPass = repeatTextField.text
        
        if (!mail!.isEmpty && !name!.isEmpty && !password!.isEmpty && !rptPass!.isEmpty) {
            if (password == rptPass) {
                apiService.login(email: mail!,password: password!)  { result in
                    switch result {
                    case .failure(let error):
                        print(error)
                        
                    case .success(let value):
                        print(value)
                    }
                }
            } else {
                toast.popMessage(message: "Passwords do not match", duration: 2.0, viewController: self)
            }
            
        } else {
            toast.popMessage(message: "You have empty fields",duration: 2.0, viewController: self)
        }
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
