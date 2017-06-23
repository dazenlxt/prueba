//
//  ViewController.swift
//  Prueba
//
//  Created by soporte 1 on 23/06/17.
//  Copyright © 2017 soporte 1. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var tableViewOverdate: UITableView!
    @IBOutlet weak var tableViewPending: UITableView!
    @IBOutlet weak var switchName: UISwitch!
    @IBOutlet weak var switchDueDate: UISwitch!
    @IBOutlet weak var switchPriority: UISwitch!
    @IBOutlet weak var form: UIView!
    
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPriority: UITextField!
    var viewModel = TaskViewModel()
    
    @IBAction func reOrder(_ sender: Any) {
        var value = viewModel.tasks.value
        viewModel.tasks.value = value
    }
    @IBAction func showNewTask(_ sender: Any) {
        form.isHidden = false
    }
    @IBAction func addTask(_ sender: Any) {
        form.isHidden = true
        self.viewModel.newTask(name: txtName.text!,dueDate: txtDueDate.text!,priority: txtPriority.text!)
        txtName.text = ""
        txtDueDate.text = ""
        txtPriority.text = ""

    }
    @IBOutlet weak var btnNew: UIButton!
    @IBOutlet weak var txtDueDate: UITextField!
    var disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.tasks.asObservable().map{ $0.filter{ $0.dueDate! >= Date() }.sorted(by: { s1,s2 -> Bool in
            if(self.switchName.isOn)
            {
                return s1.name! > s2.name!
            }
            if(self.switchDueDate.isOn)
            {
                return  s1.dueDate! > s2.dueDate!
            }
            return s1.priority! > s2.priority!
        
        }) }.bind(to: tableViewPending.rx.items(cellIdentifier: TaskCell.Identifier,
                                                  cellType: TaskCell.self)) { // 3
                                                    row, task, cell in
                                                    cell.configureWithTask(task: task) //4
            }
            .addDisposableTo(disposeBag)
        
        viewModel.tasks.asObservable().map{ $0.filter{ $0.dueDate! < Date() }.sorted(by: { s1,s2 -> Bool in
            if(self.switchName.isOn)
            {
                return s1.name! > s2.name!
            }
            if(self.switchDueDate.isOn)
            {
                return  s1.dueDate! > s2.dueDate!
            }
            return s1.priority! > s2.priority!
            
        }) }.bind(to: tableViewOverdate.rx.items(cellIdentifier: TaskCell.Identifier,
                                                                                                              cellType: TaskCell.self)) { // 3
                                                                                                                row, task, cell in
                                                                                                                cell.configureWithTask(task: task) //4
            }
            .addDisposableTo(disposeBag)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

