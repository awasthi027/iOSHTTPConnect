//
//  ErrorCode.swift
//  NetworkSDK
//
//  Created by Ashish Awasthi on 23/12/19.
//  Copyright © 2019 Ashish Awasthi. All rights reserved.
//

import Foundation

internal enum CustomErrorCode: Int {
    case json = 10001
    case noResponse = 10002
    case noError = 10003
    case noInternet = 10004
}
extension CustomErrorCode: CaseIterable {
}

extension CustomErrorCode {
    
 internal var readbleMessage: String {
        switch self {
         case .json: return "We are not getting expected json response or getting null resposne from the API"
         case .noResponse: return "No response received from API."
         case .noError: return "No error received from api."
         case .noInternet: return "No Internet connection. Please check your internet connect."
        }
    }
    
    internal func error(msg: String) ->NSError {
        switch self {
         case .json: return NSError.init(domain: "AppDomain", code: CustomErrorCode.json.rawValue, userInfo:["message": CustomErrorCode.json.readbleMessage + msg])
          case .noResponse: return NSError.init(domain: "AppDomain", code: CustomErrorCode.noResponse.rawValue, userInfo:["message": CustomErrorCode.noResponse.readbleMessage + msg])
         case .noError: return NSError.init(domain: "AppDomain", code: CustomErrorCode.noError.rawValue, userInfo:["message": CustomErrorCode.noError.readbleMessage + msg])
         case .noInternet: return NSError.init(domain: "AppDomain", code: CustomErrorCode.noInternet.rawValue, userInfo:["message": CustomErrorCode.noInternet.readbleMessage + msg])
        }
    }
}
