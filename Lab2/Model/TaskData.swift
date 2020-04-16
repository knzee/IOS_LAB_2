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
    var deadline: Date
    var category: Category
    var priority: Priority
    var created: Date
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
        self.done = try values.decode(Bool.self, forKey: .done)
        self.deadline = try values.decode(Date.self, forKey: .deadline)
        self.category = try values.decode(Category.self, forKey: .category)
        self.priority = try values.decode(Priority.self, forKey: .priority)
        self.created = try values.decode(Date.self, forKey: .created)
        
        
    }
    
}

class TaskModel {
    var apiService = APIService()
    
    var tasks = [Task]()
    
    init() {
        fetch()
    }
    
    func createTask(title: String, description: String, done: Bool, deadline: Date, category: Category, priority: Priority) {
        //apiService.postTask()
    }
    
    func fetch() {
        let priority1 = Priority(id: 1, name: "Important", color: "#8855FF")
        let category1 = Category(id: 1, name: "DUNGEON MASTERS")
        let category2 = Category(id: 2, name: "SLAVES")
        
        for id in 0..<10 {
            let title = "Title #\(id)"
            let desc = "ATAT? \(id*10)"
            //let done = Bool( (id % 2) as NSNumber)
            let done = true
            let deadline = Calendar.current.date(byAdding: Calendar.Component.minute, value: id*10, to: Date())
            var cat: Category
            if (id % 2) == 1 {
                cat = category1
            } else {
                cat = category2
            }

            let task = Task(id: id, title: title, description: desc, done: done, deadline: deadline!, category: cat, priority: priority1, created: Date())
            
            tasks.append(task)
            
        }
        
        
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
