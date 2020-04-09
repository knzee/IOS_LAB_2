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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpButtons()
        setUpTextFields()
        
    }
    
    @IBAction func openRegisterVC(_ sender: Any) {
        let viewController = RegisterVC()
        
        self.present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func Login(_ sender: Any) {
        let mail = mailTextField.text
        let password = passwordTextField.text
        
        if (mail != "" && password != "") {
            
            apiService.login(email: mail!,password: password!)  { result in
                switch result {
                case .failure(let error):
                    print(error)
                    
                case .success(let value):
                    print(value)
                }
            }
            
        } else {
            let message = "You have empty fields"
            let alert = UIAlertController(title: nil, message: message, preferredStyle: UIAlertController.Style.alert)
            
            self.present(alert, animated: true)
            
            let duration: Double = 2
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
                alert.dismiss(animated: true, completion: nil)
            }
        }
        
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
