//
//  CodableData.swift
//  Lab2
//
//  Created by Test Testovich on 10/04/2020.
//  Copyright © 2020 TSU. All rights reserved.
//

struct Token {
    var api_token: String
}

extension Token: Decodable {
    enum CodingKeys: String, CodingKey {
        case api_token
    }
}


