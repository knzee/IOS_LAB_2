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
    
    func login(email: String, password: String,completionHandler: @escaping (Result<[String: Any]>) -> Void) {
        loginRequest(email: email,password: password, completion: completionHandler)
    }
    
    func loginRequest(email: String, password: String, completion: @escaping (Result<[String: Any]>) -> Void) {
        let parameters: [String : String] = [
            "email": email,
            "password": password
        ]
        
        var response: String =  ""
        
        Alamofire.request("http://practice.mobile.kreosoft.ru/api/login", method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value as [String: Any]):
                completion(.success(value))
                
            case .failure(let error):
                completion(.failure(error))
                
            default:
                fatalError("received non-dictionary JSON response")
            }
            
        }
        
    }
}
