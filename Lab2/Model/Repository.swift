//
//  Repository.swift
//  Lab2
//
//  Created by Test Testovich on 16/04/2020.
//  Copyright © 2020 TSU. All rights reserved.

class Repository {
    
    var apiService = APIService()
    
    func getPriorities(completion: (([Priority]) -> Void)? ) {

        apiService.getPriorities { result in
            switch result {
            case .success(let value):
                completion?(value)
            case .failure(_):
                completion?([])
            }
            
        }
    }
    
    
    
    
}
