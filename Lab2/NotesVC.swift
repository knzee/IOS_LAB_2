//
//  NotesVC.swift
//  Lab2
//
//  Created by Test Testovich on 15/04/2020.
//  Copyright © 2020 TSU. All rights reserved.
//

import UIKit

class NotesVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var taskModel = TaskModel()
    
    let idCell = "testCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        self.navigationController?.isToolbarHidden = false
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "NoteViewCell", bundle: nil), forCellReuseIdentifier: idCell)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))
    }

    @objc func addTask() {
        print(228)
    }
    
}

extension NotesVC: UITableViewDataSource, UITableViewDelegate{
    /*func numberOfSections(in tableView: UITableView) -> Int {
        return 3
        
    }*/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskModel.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idCell) as! NoteViewCell
        
        let task = taskModel.tasks[indexPath.row]
        
        cell.titleLabel.text = task.title
        cell.descriptionLabel.text = task.description
        
        cell.stripeView.backgroundColor = UIColor(hexString: task.priority.color)
        
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
