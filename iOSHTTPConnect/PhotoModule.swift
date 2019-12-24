//
//  PhotoModule.swift
//  NTS
//
//  Created by Ashish Awasthi on 20/03/19.
//  Copyright © 2019 NTS. All rights reserved.
//
import Foundation


class PhotoModule: BaseModule {
    
  override internal func processRequest(requestForm: RequestForm, completeRequest: @escaping (_ result: Result<Data>) -> Void)  {
    super.processRequest(requestForm: requestForm) { (result) in
        }
    switch requestForm.requestAPI {
      case .ePhotoList:
        self.processPhotoListRequest(requestForm: requestForm) { (result) in
            completeRequest(result)
         }
        break
        case .ePhotoDetails:
            break
         default:
          break
      }
    }
}

extension PhotoModule {
    
   private func processPhotoListRequest(requestForm: RequestForm, completeRequest: @escaping(_ result: Result<Data>) ->Void) {
    let url = requestForm.requestService.moduleBaseURL + requestForm.requestAPI.requestURL
        self.requestForData(fromUrl: url, withMethod:.eGet) { (data, error) in
                      if let dataItem = data {
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
