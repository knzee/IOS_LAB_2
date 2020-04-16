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

struct User {
    var email: String
    var name: String
    var id: Int
    var api_token: String
}

extension User: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case email
        case name
        case id
        case api_token
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.email = try values.decode(String.self, forKey: .email)
        self.name = try values.decode(String.self, forKey: .name)
        self.id = try values.decode(Int.self, forKey: .id)
        self.api_token = try values.decode(String.self, forKey: .api_token)
    }

}

