//
//  Task.swift
//  Prueba
//
//  Created by soporte 1 on 23/06/17.
//  Copyright © 2017 soporte 1. All rights reserved.
//

import Foundation
import ObjectMapper

class TaskDataProxy : Mappable{
    
    var name: String?
    var dueDate: String?
    var priority: Int?
    var id: Int?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        dueDate <- map["dueDate"]
        priority <- map["priority"]
        id <- map["id"]
        
    }
    
}
class TaskData {
    
    var name: String?
    var dueDate: Date?
    var priority: Int?
    var id: Int?
    
}
