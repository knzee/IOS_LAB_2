//
//  Repository.swift
//  Lab2
//
//  Created by Test Testovich on 16/04/2020.
//  Copyright © 2020 TSU. All rights reserved.
import Foundation



class Repository {
    
    private enum Const {
        static let tokenKey = "api_token"
        
    }
    
    var apiService = APIService()
    
    //Login + Register
    func checkIfLoggedIn() -> Bool {
        
        if let ass = UserDefaults.standard.string(forKey: Const.tokenKey) {
            print(ass)
            return true
        } else {
            return false
        }
        
    }
    
    func logOff() {
        UserDefaults.standard.removeObject(forKey: Const.tokenKey)
    }
    
    func login(email: String, password: String, completion: ((Any?) -> Void)? ) {
        
        apiService.login(email: email, password: password) { loginResult in
            switch loginResult {
            case .success(let token):
                completion?(token)
                UserDefaults.standard.set(token.api_token, forKey: Const.tokenKey)
                
            case .failure(let error):
                completion?(error.localizedDescription)
            }
            
        }
    }
    
    func register(email: String, name: String, password: String, completion:  ((Token?) -> Void)?) {
        
        apiService.register(email: email, name: name, password: password) { registerResult in
            switch registerResult {
            case .success(let token):
                completion?(token)
                
            case .failure(_):
                completion?(nil)
            }
            
        }
    }
    
    //Priorities
    func getPriorities(completion: (([Priority]?) -> Void)? ) {

        apiService.getPriorities { resultPriorities in
            switch resultPriorities {
            case .success(let priorities):
                completion?(priorities)
            case .failure(_):
                completion?(nil)
            }
            
        }
    }
    
    //Categories
    func postCategory(name: String, completion: ((Category?) -> Void)? ) {
        
        apiService.postCategory(name: name) { resultCategory in
            switch resultCategory {
            case .success(let category):
                completion?(category)
                
            case .failure(_):
                completion?(nil)
            }
        }
        
    }
    
    func getCategories(completion: (([Category]?) -> Void)? ) {
        apiService.getCategories { result in
            switch result {
            case .success(let value):
                completion?(value)
            case .failure(_):
                completion?(nil)
            }
        }
    }
    
    //Tasks
    
    func postTask(title: String, description: String, done: Int, deadline: Int, category_id: Int, priority_id: Int, completion: ((Task?) -> Void)? ) {
        
        apiService.postTask(title: title, description: description, done: done, deadline: deadline, category_id: category_id, priority_id: priority_id) { resultTask in
            switch resultTask {
            case .success(let task):
                completion?(task)
            case .failure(let error):
                print(error)
                completion?(nil)
            }
        }
        
    }
    
    func patchTask(id: Int,title: String, description: String, done: Int, deadline: Int, category_id: Int, priority_id: Int, completion: ((Task?) -> Void)? ) {
        
        apiService.patchTask(id: id, title: title, description: description, done: done, deadline: deadline, category_id: category_id, priority_id: priority_id) { resultTask in
            switch resultTask {
            case .success(let task):
                completion?(task)
            case .failure(let error):
                print(error)
                completion?(nil)
            }
        }
        
    }
    
    func getTasks(completion: (([Task]?) -> Void)? ) {
        apiService.getTasks { result in
            switch result {
            case .success(let tasks):
                completion?(tasks)
            case .failure(let error):
                print(error)
                completion?(nil)
            }
        }
    }
    
    func deleteTask(id: Int, completion: ((String?) -> Void)? ) {
        apiService.deleteTask(id: id) { result in
            switch result {
            case .success(let answer):
                completion?(answer)
            case .failure(let error):
                print(error)
                completion?(nil)
            }
        }
    }
    
    
    
    
}
