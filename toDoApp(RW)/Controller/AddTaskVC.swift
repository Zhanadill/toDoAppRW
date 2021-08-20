//
//  AddTaskVC.swift
//  toDoApp(RW)
//
//  Created by Жанадил on 8/19/21.
//  Copyright © 2021 Жанадил. All rights reserved.
//

import UIKit

protocol AddTaskDelegate: class{
    func addButtonPressed(newTask: Task, priority: Int)
}


class AddTaskVC: UITableViewController {
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var addTextField: UITextField!
    var k = 0
    weak var sideDelegate: AddTaskDelegate?
    @IBOutlet weak var textfield1: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func selectPriority(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            k = 0
        case 1:
            k = 1
        case 2:
            k = 2
        default:
            k = 3
        }
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        let newTask = Task(name: addTextField.text ?? "")
        sideDelegate?.addButtonPressed(newTask: newTask, priority: k)
        
        self.dismiss(animated: true, completion: nil)
    }
}




extension AddTaskVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addTextField.endEditing(true)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           if textField.text != ""{
               addButton.isEnabled = true
           }else{
               addButton.isEnabled = false
           }
           return true
    }
}
