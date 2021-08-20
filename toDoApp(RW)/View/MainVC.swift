//
//  ViewController.swift
//  toDoApp(RW)
//
//  Created by Жанадил on 8/19/21.
//  Copyright © 2021 Жанадил. All rights reserved.
//

import UIKit


//Делегаты которые использовались для обмена данными между VC
extension MainVC: AddTaskDelegate, EditTaskDelegate{
    func addButtonPressed(newTask: Task, priority: Int){
        dataArr[priority].tasks.append(newTask)
        saveItems()
    }
    
    func editButtonPressed(task: Task, indexPath: IndexPath){
        print(task)
        dataArr[indexPath.section].tasks[indexPath.row] = task
        saveItems()
    }
}




class MainVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var dataArr = [ResponseData]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("ResponseData.plist")
    var myTask: Task?
    var indexPath: IndexPath?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Для того чтобы считывать данные напрямую из JSON файла
        //data = DataLoader().userData
        let obj1 = ResponseData(priority: "No")
        let obj2 = ResponseData(priority: "Low")
        let obj3 = ResponseData(priority: "Medium")
        let obj4 = ResponseData(priority: "High")
        dataArr.append(obj1)
        dataArr.append(obj2)
        dataArr.append(obj3)
        dataArr.append(obj4)
        
        //загружаем данные из plista
        loadItems()
    }
    
    
    //title of editbutton будет меняться
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        self.tableView.isEditing = !self.tableView.isEditing
        sender.title = (self.tableView.isEditing) ? "Done" : "Edit"
    }
    
    
    //Для хранения данных
    func saveItems(){
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(dataArr)
            try data.write(to: dataFilePath!)
        }catch{
            print(error.localizedDescription)
        }
        tableView.reloadData()
    }
    
    
    //Для того чтобы загружать данные из plista
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                dataArr = try decoder.decode([ResponseData].self, from: data)
            }catch{
                print("error is \(error)")
            }
        }
        tableView.reloadData()
    }
    
    
    //Передаем данные при переключении на другой VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue1"{
            if let selectVC = segue.destination as? AddTaskVC{
                selectVC.sideDelegate = self
            }
        }else if segue.identifier == "segue2"{
            if let selectVC = segue.destination as? EditTaskVC{
                selectVC.sideDelegate = self
                selectVC.task = myTask
                selectVC.indexPath = indexPath
            }
        }
    }
}




extension MainVC: UITableViewDataSource , UITableViewDelegate{
    
    //tableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr[section].tasks.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
        let label = cell.viewWithTag(4) as! UILabel
        let checkedLabel = cell.viewWithTag(5)
        //Если у нас completed указан как true мы перечеркиваем текст и появляется скрытая картинка checkmarka
        if dataArr[indexPath.section].tasks[indexPath.row].completed{
            let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: dataArr[indexPath.section].tasks[indexPath.row].name)
            attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedString.length))
            label.attributedText = attributedString
            checkedLabel?.isHidden = false
        }else{
            label.attributedText = .none
            checkedLabel?.isHidden = true
            label.text = dataArr[indexPath.section].tasks[indexPath.row].name
        }
        
        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArr.count
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataArr[section].priority
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    
    //TableViewDelegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myTask = dataArr[indexPath.section].tasks[indexPath.row]
        self.indexPath = indexPath
        performSegue(withIdentifier: "segue2", sender: self)
    }
    
    
    //Edit Button Settings
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObjTemp = dataArr[sourceIndexPath.section].tasks[sourceIndexPath.row]
        dataArr[sourceIndexPath.section].tasks.remove(at: sourceIndexPath.row)
        dataArr[destinationIndexPath.section].tasks.insert(movedObjTemp, at: destinationIndexPath.row)
        saveItems()
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete){
            dataArr[indexPath.section].tasks.remove(at: indexPath.item)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            saveItems()
        }
    }
    
}
