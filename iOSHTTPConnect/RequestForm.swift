//
//  RequestForm.swift
//  NetworkSDK
//
//  Created by Ashish Awasthi on 23/12/19.
//  Copyright © 2019 Ashish Awasthi. All rights reserved.
//

import Foundation

public struct RequestForm {
   public var requestService: RequestServiceModuleType = .eBase
   public var requestAPI: APIRequestType = .eUnknown
   public var postDict: [String : Any] = [:]
   public init(with service: RequestServiceModuleType = .eBase, api: APIRequestType = .eUnknown, postParam: [String : Any]) {
        self.requestService = service
        self.requestAPI = api
        self.postDict = postParam
    }
    
}
