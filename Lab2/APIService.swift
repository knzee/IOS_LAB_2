//
//  APIService.swift
//  Lab2
//
//  Created by Test Testovich on 09/04/2020.
//  Copyright © 2020 TSU. All rights reserved.
//

import Alamofire

class APIService {
    func get() {
        Alamofire.request("http://practice.mobile.kreosoft.ru/api/categories")
    }
}
