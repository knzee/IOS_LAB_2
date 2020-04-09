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


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let viewController = LoginVC()
        
        self.window?.rootViewController = viewController
        self.window?.makeKeyAndVisible()
        
        return true
    }



}

