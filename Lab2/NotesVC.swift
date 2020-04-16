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
    
    let idCell = "testCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        self.navigationController?.isToolbarHidden = false
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "NoteViewCell", bundle: nil), forCellReuseIdentifier: idCell)
    }

    @IBAction func atat(_ sender: Any) {

        let details = NotesDetailsVC()
        self.navigationController?.pushViewController(details, animated: true)
    }
    
}

extension NotesVC: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idCell) as! NoteViewCell
        
        cell.stripeView.backgroundColor = UIColor(displayP3Red: CGFloat.random(in: 0..<1), green: CGFloat.random(in: 0..<1), blue: CGFloat.random(in: 0..<1), alpha: CGFloat.random(in: 0..<1))
        
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
