
//
//  ModelController.swift
//  KishanHub
//
//  Created by Ashish Awasthi on 06/04/19.
//  Copyright © 2019 Ashish Awasthi. All rights reserved.
//

 /* PlaceModule class
 ** Which will be resposible to handle all apis requests related to place module
 ** Like get the list of place, place details, add new place, delete the place, bookmark the place, show route from current loccation
 ** Will be manage all apis request related place module
 */
import Foundation

let kLocation = "location"
class PlaceModule: BaseModule {
    
     override internal func processRequest(requestForm: RequestForm, completeRequest: @escaping (_ result: Result<Data>) -> Void)  {
      super.processRequest(requestForm: requestForm) { (result) in
          }
      switch requestForm.requestAPI {
      case .ePlaceList:
        self.processPlaceListRequest(requestForm: requestForm) { (result) in
            completeRequest(result)
         }
        break
        default:
          break
        }
    }
}

extension PlaceModule {
 
    func processPlaceListRequest(requestForm: RequestForm, completeRequest: @escaping(_ result: Result<Data>) ->Void){
        let url = requestForm.requestService.moduleBaseURL + requestForm.requestAPI.requestURL
        self.requestForData(fromUrl: url, withMethod:.eGet) { (data, error) in
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
