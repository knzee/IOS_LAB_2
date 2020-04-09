//
//  APIService.swift
//  Lab2
//
//  Created by Test Testovich on 09/04/2020.
//  Copyright © 2020 TSU. All rights reserved.
//

import Alamofire

class APIService {
    func register(email: String, name: String, password: String) {
        
        let parameters: [String : String] = [
            "email": email,
            "name": name,
            "password": password
        ]

        Alamofire.request("http://practice.mobile.kreosoft.ru/api/register", method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            print(response.value)
        }
        
    }
    
    func login(email: String, password: String) {
        let parameters: [String : String] = [
            "email": email,
            "password": password
        ]
        
        Alamofire.request("http://practice.mobile.kreosoft.ru/api/login", method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            print(response.value)
            print(response.response)
        }
        
    }
}
