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

class TaskDataService
{
    func getTasks() -> Observable<[TaskDataResponse]>
    {
        return Observable<[TaskDataResponse]>.create { observer in
            
            
            let request = MyManager.sharedInstance.defaultManager.request("\(BaseUrl)getTasks".addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)!, method: .get)
                
                request.validate()
                .responseArray { (response: DataResponse<[TaskDataResponse]>) in
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
    func postTask(name: String,dueDate: String, priority: String) -> Observable<DefaultResponse>
    {
        return Observable<DefaultResponse>.create { observer in
            
            let parameters = [
                "priority": priority,
                "name": name,
                "dueDate": dueDate
            ]
            let request = MyManager.sharedInstance.defaultManager.request("\(BaseUrl)postTask".addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)!, method: .post, parameters: parameters)
            
            request.validate()
                .responseObject { (response: DataResponse<DefaultResponse>) in
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
}

class MyManager {
    static let sharedInstance = MyManager()
    
    let defaultManager: Alamofire.SessionManager = {
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "190.131.203.107": .disableEvaluation
        ]
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        return Alamofire.SessionManager(
            configuration: configuration,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
    }()
}
