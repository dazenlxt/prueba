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
    var taskDataService = TaskDataService()
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
        getTasks()
        
    }
    func getTasks()
    {
        taskDataService.getTasks().subscribe(onNext: { data in
            print(data)
            DispatchQueue.main.async() {
                self.tasks.value = data.map{ s1 -> TaskData in
                    let task = TaskData()
                    task.name = s1.name
                    task.priority = s1.priority
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    task.dueDate = dateFormatter.date(from: s1.dueDate!)
                    return task }
            }
        }, onError: { error in
            print(error)
        },
           onCompleted: {
            print("Completed")
        },
           onDisposed: {
            print("Disposed")
        }).addDisposableTo(disposeBag)
    }
    func newTask(name: String,dueDate: String, priority: String)
    {
        taskDataService.postTask(name: name,dueDate: dueDate, priority: priority).subscribe(onNext: { data in
            print(data)
            DispatchQueue.main.async() {
                if(data.isSuccess)!
                {
                    self.getTasks()
                }
            }
        }, onError: { error in
            print(error)
        },
           onCompleted: {
            print("Completed")
        },
           onDisposed: {
            print("Disposed")
        }).addDisposableTo(disposeBag)
    }
}
