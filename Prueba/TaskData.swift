//
//  Task.swift
//  Prueba
//
//  Created by soporte 1 on 23/06/17.
//  Copyright © 2017 soporte 1. All rights reserved.
//

import Foundation
import ObjectMapper

class TaskDataResponse : Mappable{
    
    var name: String?
    var dueDate: String?
    var priority: Int?
    var id: Int?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        name <- map["Name"]
        dueDate <- map["DueDate"]
        priority <- map["Priority"]
        id <- map["Id"]
        
    }
    
}
class TaskData {
    
    var name: String?
    var dueDate: Date?
    var priority: Int?
    var id: Int?
    
}

class DefaultResponse : Mappable{
    var error_description: String?
    var error: String?
    var isSuccess: Bool?
    var id: Int?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        error <- map["error"]
        id <- map["id"]
        isSuccess <- map["isSuccess"]
        error_description <- map["error_description"]
        
    }
}
