//
//  APIService.swift
//  Lab2
//
//  Created by Test Testovich on 09/04/2020.
//  Copyright © 2020 TSU. All rights reserved.
//

import Alamofire

private enum Const {
    static let baseURL = "http://practice.mobile.kreosoft.ru/api/"
    static let register = "register"
    static let login = "login"
    
    static func registerURL() -> String {
        return baseURL + register
    }
    
    static func loginURL() -> String {
        return baseURL + login
    }
}

class APIService {
    func register(email: String, name: String, password: String,completionHandler: @escaping (Result<[String: Any]>) -> Void) {
        registerRequest(email: email,name: name, password: password, completion: completionHandler)
    }
    
    func registerRequest(email: String, name: String, password: String, completion: @escaping (Result<[String: Any]>) -> Void) {
        
        let parameters: [String : String] = [
            "email": email,
            "name": name,
            "password": password
        ]

        Alamofire.request(Const.registerURL(), method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
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
    
   
    func login(email: String, password: String, completion: ((Result<Token>) -> Void)? ) {
        let parameters: [String : String] = [
            "email": email,
            "password": password
        ]
        
        let request = Alamofire.request(
            Const.loginURL(),
            method: HTTPMethod.post,
            parameters: parameters,
            encoding: JSONEncoding.default)
        
        request.responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let payload = try JSONDecoder().decode(Token.self, from: data)
                    completion?(.success(payload))
                } catch let error {
                    completion?(.failure(error))
                }
            case .failure(let error):
                completion?(.failure(error))
            }
        }
        
    }
}
