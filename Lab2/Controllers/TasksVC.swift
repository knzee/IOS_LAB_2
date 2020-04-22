//
//  NotesVC.swift
//  Lab2
//
//  Created by Test Testovich on 15/04/2020.
//  Copyright © 2020 TSU. All rights reserved.
//

import UIKit
import Kingfisher

protocol updateControl {
    func updateTasks()
}

class TasksVC: UIViewController, updateControl {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var notaskLabel: UILabel!
    @IBOutlet weak var placeholderImageView: UIImageView!
    
    var refreshControl = UIRefreshControl()
    
    var repository = Repository()
    
    var tasks: [Task] = []
    var tasksDictionary: Dictionary<Int,[Task]> = [:]
    var categories: [Category] = []
    
    let idCell = "testCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBar()
        
        setUpPlaceHolderImage()
        
        setUpTableView()
        
        updateTasks()
    }
    
    func setUpNavigationBar() {
        self.title = "Not Forgot!"
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 34)]

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.trash, target: self, action: #selector(logOff))

    }
    
    func setUpPlaceHolderImage() {
        let imageURL = URL(string: "https://loremflickr.com/g/640/480/holiday")
        placeholderImageView.kf.setImage(with: imageURL)
        placeholderImageView.alpha = 0.5
    }
    
    func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "TaskViewCell", bundle: nil), forCellReuseIdentifier: idCell)
        
        tableView.refreshControl = refreshControl
        refreshControl.attributedTitle = NSAttributedString(string: "Updating")
        refreshControl.addTarget(self, action: #selector(updateTable), for: UIControl.Event.valueChanged)
        
    }
    
    @objc func updateTable() {
        updateTasks()
        refreshControl.endRefreshing()
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
    
    @objc func logOff() {
        repository.logOff()
        let loginVC = LoginVC()
        
        self.present(loginVC, animated: true, completion: nil)
    }
    
    @objc func addTask() {
        
        let tasksCreateVC = TasksCreateVC()
        tasksCreateVC.delegate = self
        self.navigationController?.pushViewController(tasksCreateVC, animated: true)
        
    }
    
}




extension TasksVC {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let swipeDelete = UIContextualAction(style: UIContextualAction.Style.normal, title: "Delete") { (action, view, success) in
            
            
            let taskID = self.tasksDictionary[self.categories[indexPath.section].id]![indexPath.row].id
            
            self.repository.deleteTask(id: taskID, completion: { answer in
                if answer != nil {
                    self.updateTasks()
                }
            })
        }
        swipeDelete.backgroundColor = UIColor.red
        
        return UISwipeActionsConfiguration(actions: [swipeDelete])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = self.tasksDictionary[self.categories[indexPath.section].id]![indexPath.row]
        let tasksDetailsVC = TasksDetailsVC()
        tasksDetailsVC.delegate = self
        tasksDetailsVC.task = task
        tasksDetailsVC.title = task.title
        
        self.navigationController?.pushViewController(tasksDetailsVC, animated: true)
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
        
        return categories.count
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.tasks.count > 0 && self.tableView.isHidden {
            self.revertViewVisibility()
        }
        
        return tasksDictionary[categories[section].id]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idCell) as! TaskViewCell
        
        let task = tasksDictionary[categories[indexPath.section].id]![indexPath.row]
        
        cell.titleLabel.text = task.title
        cell.descriptionLabel.text = task.description
        
        cell.stripeView.backgroundColor = UIColor(hexString: task.priority!.color)
        
        if task.done == true {
            cell.doneButton.setImage(UIImage(named: "checked.png"), for: UIControl.State.normal)
            cell.doneButton.removeTarget(self, action: #selector(checkDone(sender:)), for: UIControl.Event.touchUpInside)
        } else {
            cell.doneButton.setImage(UIImage(named: "unchecked.png"), for: UIControl.State.normal)
            cell.doneButton.row = indexPath.row
            cell.doneButton.section = indexPath.section
            
            cell.doneButton.addTarget(self, action: #selector(checkDone(sender:)), for: UIControl.Event.touchUpInside)
        }
        
        return cell
    }
    
    @objc func checkDone(sender: CheckBox) {
        let row = sender.row!
        let section = sender.section!
        
        let task = tasksDictionary[categories[section].id]![row]

        repository.patchTask(id: task.id, title: task.title, description: task.description, done: 1, deadline: task.deadline, category_id: task.category!.id, priority_id: task.priority!.id) { test in
            if test != nil {
                self.updateTasks()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section].name
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
}
