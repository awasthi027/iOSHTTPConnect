//
//  NoticeModule.swift
//  iOSHTTPConnect
//
//  Created by Ashish Awasthi on 08/02/20.
//  Copyright © 2020 Ashish Awasthi. All rights reserved.
//

import Foundation


class MovieInfoModule: BaseModule {
    
    override internal func processRequest(requestForm: RequestForm, completeRequest: @escaping (_ result: Result<Data>) -> Void)  {
        super.processRequest(requestForm: requestForm) { (result) in
            if let _ = result.error {
                completeRequest(result)
                return
            }
            switch requestForm.methodType {
            case .eGet:
                self.processGetRequest(requestForm: requestForm) { (result) in
                    completeRequest(result)
                }
                break
            case .ePost:
                break
            case .ePatch:
                break
            case .ePut:
                break
            case .eDelete:
                break
            }
        }
    }
}

extension MovieInfoModule {
 
    func processGetRequest(requestForm: RequestForm, completeRequest: @escaping(_ result: Result<Data>) ->Void){
        let url = requestForm.requestService.moduleBaseURL + requestForm.requestAPI.requestURL
        self.requestForData(fromUrl: url, withMethod:requestForm.methodType.methodName) { (data, error) in
            if let dataItem  = data {
                completeRequest(.success(dataItem))
            }else {
                if let errorItem = error {
                    completeRequest(.failure(errorItem))
                }else {
                   completeRequest(.failure(CustomErrorCode.noResponse.error(msg: url)))
                }
            }
        }
    }
  
}
