//
//  GenericOperation.swift
//  NTS
//
//  Created by Ashish Awasthi on 20/03/19.
//  Copyright © 2019 NTS. All rights reserved.
//
import Foundation

class GenericOperation: BaseOperation {
    
    var requestForm: RequestForm
    var baseModel: BaseModule
    var result: Result<Data>? = nil
    
    init(requestForm: RequestForm) {
      let module = requestForm.requestService.classObject
      self.requestForm = requestForm
      self.baseModel = module
    }
    
    override func main() {
           guard isCancelled == false else {
               finish(true)
               return
           }
           executing(true)
           self.baseModel.processRequest(requestForm: self.requestForm) { (result) in
               self.result = result
               self.executing(false)
               self.finish(true)
           }
       }
}
