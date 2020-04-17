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
    var taskModel = TaskModel()
    let tasksCreateVC = TasksCreateVC()
    
    var repository = Repository()
    
    var priorities: [Priority] = []
    
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
        
    }
    
    func revertViewVisibility() {
        placeholderImageView.isHidden = !placeholderImageView.isHidden
        tableView.isHidden = !tableView.isHidden
        notaskLabel.isHidden = !notaskLabel.isHidden
    }

    @objc func addTask() {
        

        /*repository.getPriorities { ass in
            self.priorities = ass
            self.tableView.reloadData()
            print(self.priorities)
        }*/
        self.navigationController?.pushViewController(tasksCreateVC, animated: true)
        
        
    }
    
}

extension TasksVC {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let swipeDelete = UIContextualAction(style: UIContextualAction.Style.normal, title: "Delete") { (action, view, success) in
            print("delete")
        }
        swipeDelete.backgroundColor = UIColor.red
        
        return UISwipeActionsConfiguration(actions: [swipeDelete])
    }
}

extension TasksVC: UITableViewDataSource, UITableViewDelegate{
    /*func numberOfSections(in tableView: UITableView) -> Int {
        return 3
        
    }*/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.priorities.count > 0 && self.tableView.isHidden {
            self.revertViewVisibility()
        }
        return self.priorities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idCell) as! TaskViewCell
        
        let task = self.priorities[indexPath.row]
        
        cell.titleLabel.text = task.name
        cell.descriptionLabel.text = task.color
        
        cell.stripeView.backgroundColor = UIColor(hexString: task.color)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "section"
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
    }
}
