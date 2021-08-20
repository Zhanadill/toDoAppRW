//
//  EditTaskVC.swift
//  toDoApp(RW)
//
//  Created by Жанадил on 8/20/21.
//  Copyright © 2021 Жанадил. All rights reserved.
//

import UIKit

protocol EditTaskDelegate: class{
    func editButtonPressed(task: Task, indexPath: IndexPath)
}


class EditTaskVC: UITableViewController {

    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var textField1: UITextField!
    var task: Task?
    var indexPath: IndexPath?
    weak var sideDelegate: EditTaskDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationItem.hidesBackButton = true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        textField1.text = task?.name ?? " "
        navigationItem.title = task?.name ?? " "
        mySwitch.isOn = task?.completed ?? false
    }
    
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        task?.name = textField1.text ?? ""
        task?.completed = mySwitch.isOn
        sideDelegate?.editButtonPressed(task: task!, indexPath: indexPath!)
        navigationController?.popToRootViewController(animated: true)
    }
    
}



//UITextFieldDelegate Methods
extension EditTaskVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField1.endEditing(true)
        return true
    }
    
    
    //В режиме реального времени title of navigationItem будет получать значение нашего textField-a
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.navigationItem.title = self.textField1.text
        }
        return true
    }
}
