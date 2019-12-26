//
//  ModelController.swift
//  NTS
//
//  Created by Ashish Awasthi on 20/03/19.
//  Copyright © 2019 NTS. All rights reserved.
//
import Foundation

public class ModelController {
  public static let shared = ModelController()
  public var accessToken: String = ""
  var operationQueue = OperationQueue()
  private init() {}
    
}

extension ModelController {
    
    public func processRequest<JSONElement: Decodable>(requestForm: RequestForm, jsonObjType: JSONElement.Type, completeRequest: @escaping (_ result: Result<[String: Any]>) -> Void) {
        FSFrameworkVersion()
        let genericOperation = GenericOperation.init(requestForm: requestForm)
        self.operationQueue.addOperations([genericOperation], waitUntilFinished: false)
        genericOperation.completionBlock = {
            if let result = genericOperation.result, result.isSuccess, let data = result.value {
                let module = RequestServiceModuleType.eBase.classObject
                module.decodeData(raw: data, withType: jsonObjType.self) { (obj, error) in
                    if let jsonObj = obj {
                        completeRequest(.success([kResponse: jsonObj]))
                    }else {
                        if let errorItem = error {
                            completeRequest(.failure(errorItem))
                        }else {
                            completeRequest(.failure(CustomErrorCode.json.error(msg: "")))
                        }
                    }
                }
            }else {
                completeRequest(.failure(CustomErrorCode.noResponse.error(msg: "")))
            }
        }
        
    }
}
