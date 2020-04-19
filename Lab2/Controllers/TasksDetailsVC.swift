//
//  NotesDetailsVC.swift
//  Lab2
//
//  Created by Test Testovich on 15/04/2020.
//  Copyright © 2020 TSU. All rights reserved.
//

import UIKit

class TasksDetailsVC: UIViewController {

    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var doneLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var priorityLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    var delegate: updateControl?
    
    var task: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateLabel.text = dateFormatter.string(from: Date(timeIntervalSince1970: Double(task?.created ?? 0)))
        
        if task?.done == true {
            doneLabel.text = "Done"
            doneLabel.textColor = UIColor.black
        } else {
            doneLabel.text = "Not done"
            doneLabel.textColor = UIColor.red
        }
        
        descriptionTextView.text = task?.description
        
        let dl = dateFormatter.string(from: Date(timeIntervalSince1970: Double(task?.deadline ?? 0)))
        deadlineLabel.text = "Deadline: \(dl)"
        
        categoryLabel.text = task?.category!.name
        
        priorityLabel.text = task?.priority!.name
        priorityLabel.backgroundColor = UIColor(hexString: task?.priority!.color ?? "FFFFFF")
        
    }


    
    @IBAction func editTask(_ sender: Any) {
        let tasksCreateVC = TasksCreateVC()
        tasksCreateVC.delegate = self.delegate
        tasksCreateVC.task = self.task!
        self.navigationController?.pushViewController(tasksCreateVC, animated: true)
    }


}
