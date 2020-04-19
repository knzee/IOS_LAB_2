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
    static let priorities = "priorities"
    static let categories = "categories"
    static let tasks = "tasks"
    
    static func registerURL() -> String {
        return baseURL + register
    }
    
    static func loginURL() -> String {
        return baseURL + login
    }
    
    static func prioritiesURL() -> String {
        return baseURL + priorities
    }
    
    static func categoriesURL() -> String {
        return baseURL + categories
    }
    
    static func tasksURL() -> String {
        return baseURL + tasks
    }

}

class APIService {
    //Registration
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
    
   //Login
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
    
    //Priorities
    func getPriorities(completion: ((Result<[Priority]>) -> Void)?) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + "LUMLlCCEgnJOemXQOsFMmPpwVs0FMSOHbJhxIDXQLLnR7MD8o2n86q2teY7j",
            "Accept": "application/json"
        ]
        
        let decoder = JSONDecoder()
        
        let request = Alamofire.request(Const.prioritiesURL(), method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
        
        request.responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let payload = try decoder.decode([Priority].self, from: data)
                    completion?(.success(payload))
                } catch let error {
                    completion?(.failure(error))
                }
            case .failure(let error):
                completion?(.failure(error))
            }
        }
  
        
    }
    
    //Categories
    func getCategories(completion: ((Result<[Category]>) -> Void)?) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + "LUMLlCCEgnJOemXQOsFMmPpwVs0FMSOHbJhxIDXQLLnR7MD8o2n86q2teY7j",
            "Accept": "application/json"
        ]
        
        let decoder = JSONDecoder()
        
        let request = Alamofire.request(Const.categoriesURL(), method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
        
        request.responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let payload = try decoder.decode([Category].self, from: data)
                    completion?(.success(payload))
                } catch let error {
                    completion?(.failure(error))
                }
            case .failure(let error):
                completion?(.failure(error))
            }
        }
        
        
    }
    
    func postCategory(name: String, completion: ((Result<Category>) -> Void)?) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + "LUMLlCCEgnJOemXQOsFMmPpwVs0FMSOHbJhxIDXQLLnR7MD8o2n86q2teY7j",
            "Accept": "application/json"
        ]
        
        let parameters: [String : String] = [
            "name": name
        ]
        
        let request = Alamofire.request(Const.categoriesURL(), method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        
        request.responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    print(String(decoding: data, as: UTF8.self))
                    let payload = try JSONDecoder().decode(Category.self, from: data)
                    completion?(.success(payload))
                } catch let error {
                    completion?(.failure(error))
                }
            case .failure(let error):
                completion?(.failure(error))
            }
        }
        
    }
    
    //Tasks
    func getTasks(completion: ((Result<[Task]>) -> Void)?) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + "LUMLlCCEgnJOemXQOsFMmPpwVs0FMSOHbJhxIDXQLLnR7MD8o2n86q2teY7j",
            "Accept": "application/json"
        ]
        
        let decoder = JSONDecoder()
        
        let request = Alamofire.request(Const.tasksURL(), method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
        
        request.responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let payload = try decoder.decode([Task].self, from: data)
                    completion?(.success(payload))
                } catch let error {
                    completion?(.failure(error))
                }
            case .failure(let error):
                completion?(.failure(error))
            }
        }
        
        
    }
    
    func postTask(title: String, description: String, done: Int, deadline: Int, category_id: Int, priority_id: Int, completion: ((Result<Task>) -> Void)?) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + "LUMLlCCEgnJOemXQOsFMmPpwVs0FMSOHbJhxIDXQLLnR7MD8o2n86q2teY7j",
            "Accept": "application/json"
        ]
        
        let parameters: [String : Any] = [
            "title": title,
            "description": description,
            "done": done,
            "deadline": deadline,
            "category_id": category_id,
            "priority_id": priority_id
        ]
        
        let request = Alamofire.request(Const.tasksURL(), method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        
        request.responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    print(String(decoding: data, as: UTF8.self))
                    let payload = try JSONDecoder().decode(Task.self, from: data)
                    completion?(.success(payload))
                } catch let error {
                    completion?(.failure(error))
                }
            case .failure(let error):
                completion?(.failure(error))
            }
        }
        
    }
    
    func deleteTask(id: Int, completion: ((Result<String>) -> Void)?) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + "LUMLlCCEgnJOemXQOsFMmPpwVs0FMSOHbJhxIDXQLLnR7MD8o2n86q2teY7j",
            "Accept": "application/json"
        ]
        
        let request = Alamofire.request(Const.tasksURL() + "/\(id)", method: HTTPMethod.delete, parameters: nil, encoding: JSONEncoding.default, headers: headers)
        
        request.responseData { response in
            switch response.result {
            case .success(_):
                completion?(.success("Successful deletion"))

            case .failure(let error):
                completion?(.failure(error))
            }
        }
        
        
    }
    
}
