//
//  TaskViewModel.swift
//  Prueba
//
//  Created by soporte 1 on 23/06/17.
//  Copyright © 2017 soporte 1. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON

public class TaskViewModel {
    var tasks: Variable<[TaskData]> = Variable([])
    var disposeBag = DisposeBag()
    var hideForm = Variable<Bool>(true)
    var name = Variable<String>("")
    var duedate = Variable<String>("")
    var priority = Variable<String>("")
    var isValid : Observable<Bool>{
        return Observable.combineLatest( self.name.asObservable(), self.duedate.asObservable(),self.priority.asObservable())
        { (name, duedate,priority) in
            return name.characters.count > 0
                && duedate.characters.count > 0
                && priority.characters.count > 0
        }
    }
    init()
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let data1 = TaskData()
        data1.name = "Proxy"
        data1.dueDate = dateFormatter.date(from: "2017-02-23")
        data1.priority = 1
        self.tasks.value.append(data1)
        let data2 = TaskData()
        data2.name = "Proxy2"
        data2.dueDate = dateFormatter.date(from: "2017-06-26")
        data2.priority = 3
        self.tasks.value.append(data2)
        let data3 = TaskData()
        data3.name = "Proxy3"
        data3.dueDate = dateFormatter.date(from: "2017-03-03")
        data3.priority = 5
        self.tasks.value.append(data3)
        let data4 = TaskData()
        data4.name = "Proxy4"
        data4.dueDate = dateFormatter.date(from: "2017-08-15")
        data4.priority = 2
        self.tasks.value.append(data4)
        
    }
    func newTask(name: String,dueDate: String, priority: String)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let data = TaskData()
        data.name = name
        data.dueDate = dateFormatter.date(from: dueDate)
        data.priority = Int(priority)
        self.tasks.value.append(data)
    }
}
