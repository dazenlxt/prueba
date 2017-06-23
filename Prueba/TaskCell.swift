//
//  TaskCell.swift
//  Prueba
//
//  Created by soporte 1 on 23/06/17.
//  Copyright © 2017 soporte 1. All rights reserved.
//

import Foundation
import UIKit

class TaskCell : UITableViewCell
{
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var dueDate: UILabel!
    @IBOutlet weak var priority: UILabel!
    static let Identifier = "TaskCell"
    
    func configureWithTask(task: TaskData) {
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date
        formatter.dateFormat = "yyyy-MM-dd"
        
        name.text = task.name!
        dueDate.text = formatter.string(from: task.dueDate!)
        priority.text = "\(task.priority!)"
    }
}
