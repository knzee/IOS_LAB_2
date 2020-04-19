//
//  Repository.swift
//  Lab2
//
//  Created by Test Testovich on 16/04/2020.
//  Copyright © 2020 TSU. All rights reserved.

class Repository {
    
    var apiService = APIService()
    
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
