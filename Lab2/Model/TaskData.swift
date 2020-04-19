//
//  TaskData.swift
//  Lab2
//
//  Created by Test Testovich on 16/04/2020.
//  Copyright © 2020 TSU. All rights reserved.
//

import Foundation

struct Task {
    var id: Int
    var title: String
    var description: String
    var done: Bool
    var deadline: Int
    var category: Category?
    var priority: Priority?
    var created: Int
}

extension Task: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case done
        case deadline
        case category
        case priority
        case created
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.title = try values.decode(String.self, forKey: .title)
        self.description = try values.decode(String.self, forKey: .description)
        //self.done = try values.decode(Bool.self, forKey: .done)
        
        self.deadline = try values.decode(Int.self, forKey: .deadline)
        self.category = try values.decode(Category.self, forKey: .category)
        self.priority = try values.decode(Priority.self, forKey: .priority)
        self.created = try values.decode(Int.self, forKey: .created)
        
        let intDone = try values.decodeIfPresent(Int.self, forKey: .done)
        self.done = intDone == 1 ? true : false
        
        
    }
    
}



struct Category {
    var id: Int
    var name: String
}

extension Category: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try values.decode(String.self, forKey: .name)
        self.id = try values.decode(Int.self, forKey: .id)
    }
    
}

struct Priority {
    var id: Int
    var name: String
    var color: String
}

extension Priority: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case color
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.name = try values.decode(String.self, forKey: .name)
        self.color = try values.decode(String.self, forKey: .color)
    }
    
}
