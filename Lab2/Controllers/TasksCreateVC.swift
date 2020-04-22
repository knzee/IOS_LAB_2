//
//  NotesCreateVC.swift
//  Lab2
//
//  Created by Test Testovich on 15/04/2020.
//  Copyright © 2020 TSU. All rights reserved.
//

import UIKit

class TasksCreateVC: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextEdit: UITextView!
    
    @IBOutlet weak var createTaskButton: UIButton!
    @IBOutlet weak var addCategoryButton: UIButton!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var priorityTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var inputsView: UIView!
    
    let picker = UIPickerView()
    let datePicker = UIDatePicker()
    
    var delegate: updateControl?
    
    var repository = Repository()
    
    var task: Task?
    var editMode: Bool = false
    
    var categories: [Category] = []
    var priorities: [Priority] = []
    
    let test: [String] = ["1a","2b","3c","4d","5e"]
    
    let cellId = "CELLID"
    
    var isCategorySelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpInputsView()
        
        setUpPicker()
        setUpDatePicker()
        
        initTask()
        
    }
    
    func setUpInputsView() {
        inputsView.layer.shadowColor = UIColor.black.cgColor
        inputsView.layer.shadowOpacity = 0.1
        inputsView.layer.cornerRadius = 0
        inputsView.layer.shadowRadius = 2
        inputsView.layer.shadowOffset = CGSize(width: 0, height: 1)
        createTaskButton.setBorderRadius(radius: 3.0)
    }
    
    func initTask() {
        if task != nil {
            editMode = true
            titleTextField.text = task!.title
            descriptionTextEdit.text = task!.description
            categoryTextField.text = task!.category!.name
            priorityTextField.text = task!.priority!.name
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm    dd-MM-yyyy"
            let dl = dateFormatter.string(from: Date(timeIntervalSince1970: Double(task!.deadline)))
            dateTextField.text = dl
            
            createTaskButton.setTitle("Save", for: UIControl.State.normal)
        } else {
            task = Task(id: -1, title: "", description: "", done: false, deadline: 0, category: nil, priority: nil, created: 0)
        }
        
    }

    func setUpDatePicker() {
        
        let toolBar = UIToolbar().toolbarPicker(selector: #selector(applyDate))
        dateTextField.inputAccessoryView = toolBar
        dateTextField.inputView = datePicker
        
    }
    
    @objc func applyDate() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm    dd-MM-yyyy"
        dateTextField.text = dateFormatter.string(from: datePicker.date)
        task!.deadline = Int(datePicker.date.timeIntervalSince1970)
        
        view.endEditing(true)
    }
    
    func setUpPicker() {
        let toolBar = UIToolbar().toolbarPicker(selector: #selector(finishEditing))
        
        picker.showsSelectionIndicator = true
        picker.clearsContextBeforeDrawing = true
        
        
        categoryTextField.delegate = self
        priorityTextField.delegate = self
        
        categoryTextField.inputView = picker
        priorityTextField.inputView = picker
        
        categoryTextField.inputAccessoryView = toolBar
        priorityTextField.inputAccessoryView = toolBar

        picker.dataSource = self
        picker.delegate = self
        
    }

    @objc func finishEditing() {
        let row = picker.selectedRow(inComponent: 0)
        if isCategorySelected {
            categoryTextField.text = categories[row].name
            task!.category = categories[row]
        } else {
            priorityTextField.text = priorities[row].name
            task!.priority = priorities[row]
        }
        
        self.view.endEditing(true)
    }
    
    @IBAction func createCategory(_ sender: Any) {
        let alert = UIAlertController(title: "Add category", message: "Type the name of the new category", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Category name"
        })
        
        let createCategory = UIAlertAction(title: "Create", style: UIAlertAction.Style.default) { action in
            if let name = alert.textFields?.first?.text {
                self.repository.postCategory(name: name, completion: { resultCategory in
                    if (resultCategory != nil) {
                        self.task!.category = resultCategory!
                        self.categoryTextField.text = resultCategory!.name
                    }
                    
                    
                })
                
            }
        }
        
        alert.addAction(createCategory)
        
        self.present(alert, animated: true)
    }
    
    
    
    @IBAction func createTask(_ sender: Any) {
        
        
        if !titleTextField.text!.isEmpty && task!.category != nil && task!.priority != nil && task!.deadline != -1 {
            task!.title = titleTextField.text!
            task!.description = descriptionTextEdit.text
            
            if !editMode {
                repository.postTask(title: task!.title, description: task!.description, done: Int(truncating: NSNumber(value: task!.done)), deadline: task!.deadline, category_id: task!.category!.id, priority_id: task!.priority!.id) { test in
                    if test != nil {
                        self.delegate?.updateTasks()
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                }
            } else {
                repository.patchTask(id: task!.id, title: task!.title, description: task!.description, done: Int(truncating: NSNumber(value: task!.done)), deadline: task!.deadline, category_id: task!.category!.id, priority_id: task!.priority!.id) { test in
                    if test != nil {
                        self.delegate?.updateTasks()
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                }
            }
        
            
        } else {
            Toast().popMessage(message: "You have empty fields", duration: 2, viewController: self)
        }
        
        
        
    }
}

extension TasksCreateVC: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == categoryTextField {
            
            isCategorySelected = true
            repository.getCategories { resultCategories in
                if (resultCategories != nil) {
                    self.categories = resultCategories!
                } else {
                    self.categories = []
                }
                self.picker.reloadAllComponents()
            }
            
        }
        
        if textField == priorityTextField {
            isCategorySelected = false
            repository.getPriorities{ resultPriorities in
                if (resultPriorities != nil) {
                    self.priorities = resultPriorities!
                } else {
                    self.priorities = []
                }
                
                self.picker.reloadAllComponents()
            }
        }
        
        return true
    }
}



extension TasksCreateVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if self.isCategorySelected {
            return self.categories.count
        }
        return self.priorities.count
    }
}

extension TasksCreateVC: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var name = "none"
        
        if isCategorySelected {
            name = self.categories[row].name
        } else {
            name = self.priorities[row].name
        }
        
        return name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {}
}

