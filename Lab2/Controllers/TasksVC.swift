//
//  NotesVC.swift
//  Lab2
//
//  Created by Test Testovich on 15/04/2020.
//  Copyright © 2020 TSU. All rights reserved.
//

import UIKit
import Kingfisher

class TasksVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var notaskLabel: UILabel!
    @IBOutlet weak var placeholderImageView: UIImageView!

    let tasksCreateVC = TasksCreateVC()
    
    var repository = Repository()
    
    var tasks: [Task] = []
    var tasksDictionary: Dictionary<Int,[Task]> = [:]
    var categories: [Category] = []
    
    let idCell = "testCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        self.navigationController?.isToolbarHidden = false
        
        let imageURL = URL(string: "https://loremflickr.com/g/640/480/holiday")
        placeholderImageView.kf.setImage(with: imageURL)
        placeholderImageView.alpha = 0.5
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "TaskViewCell", bundle: nil), forCellReuseIdentifier: idCell)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))
        
        updateTasks()
        
    }
    
    func updateTasks() {
        repository.getTasks { resultTasks in
            if (resultTasks != nil) {
                self.tasks = resultTasks!
                print("***UPDATING***")
                self.tableView.reloadData()
            }

        }
    }
    
    func revertViewVisibility() {
        placeholderImageView.isHidden = !placeholderImageView.isHidden
        tableView.isHidden = !tableView.isHidden
        notaskLabel.isHidden = !notaskLabel.isHidden
    }

    @objc func addTask() {
        
        self.navigationController?.pushViewController(tasksCreateVC, animated: true)
        
    }
    
}

extension TasksVC {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let swipeDelete = UIContextualAction(style: UIContextualAction.Style.normal, title: "Delete") { (action, view, success) in
           
            self.repository.deleteTask(id: self.tasks[indexPath.row].id, completion: { answer in
                if answer != nil {
                    self.updateTasks()
                }
            })
        }
        swipeDelete.backgroundColor = UIColor.red
        
        return UISwipeActionsConfiguration(actions: [swipeDelete])
    }
}

extension TasksVC: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        
        categories = []
        tasksDictionary = [:]
        
        tasksDictionary = Dictionary(grouping: tasks) { $0.category!.id }
        
        for task in tasks {
            if !categories.contains(where: { $0.id == task.category!.id}) {
                categories.append(task.category!)
            }
            
        }
        
        let categoryCount = categories.count
        //print("categories: \(categories); count = \(categoryCount)")
        
        return categoryCount
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.tasks.count > 0 && self.tableView.isHidden {
            self.revertViewVisibility()
        }
        
        //let tasksPerCategory = tasks.filter { $0.category!.id == categories[section].id }.count
        //print("\(section) - \()")
        return tasksDictionary[categories[section].id]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idCell) as! TaskViewCell
        
        let task = tasksDictionary[categories[indexPath.section].id]![indexPath.row]
        
        cell.titleLabel.text = task.title
        cell.descriptionLabel.text = task.description
        
        cell.stripeView.backgroundColor = UIColor(hexString: task.priority!.color)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section].name
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
    }
}
