//
//  TaskDataService.swift
//  Prueba
//
//  Created by soporte 1 on 23/06/17.
//  Copyright © 2017 soporte 1. All rights reserved.
//

import Foundation


import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import SwiftyJSON
import RxSwift
/*
class TaskDataService
{
    func getTasks() -> Observable<[TaskData]>
    {
        return Observable<[TaskData]>.create { observer in
            var request = Alamofire.request("\(BaseUrl)task".addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)!, method: .get)
                
                request.validate()
                .responseArray { (response: DataResponse<[TaskDataProxy]>) in
                    guard let value = response.result.value else {
                        //let error = HTTPError(response: response.response)
                        //observer.onError(error)
                        return
                    }
                    
                    observer.onNext(value)
                    observer.onCompleted()
            }
            return Disposables.create {
                request.cancel()
            }
        }
        
    }
}*/
