//
//  AppDelegate.swift
//  Lab2
//
//  Created by Test Testovich on 08/04/2020.
//  Copyright © 2020 TSU. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var repository = Repository()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let logInCheck = repository.checkIfLoggedIn()
        
        var viewController: UIViewController
        
        if logInCheck {
            let tasksVC = TasksVC()
            let nav = UINavigationController(rootViewController: tasksVC)
            
            viewController = nav
        } else {
            viewController = LoginVC()
        }
        
        self.window?.rootViewController = viewController
        self.window?.makeKeyAndVisible()
        
        return true
    }



}

