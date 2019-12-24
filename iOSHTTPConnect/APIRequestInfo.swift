//
//  APIRequestInfo.swift
//  NTS
//
//  Created by Ashish Awasthi on 22/12/19.
//  Copyright © 2019 Ashish Awasthi. All rights reserved.
//

import Foundation

public enum APIRequestType: Int {
    case eLogin = 0
    case eSignUp
    case ePhotoList
    case ePhotoDetails
    case ePlaceList
    case eUnknown
}

extension APIRequestType: CaseIterable {
    
}
// MARK:: Compose URL
extension APIRequestType {
    
    internal var requestURL: String {
        switch self {
        case .ePhotoList: return ""
        case .ePhotoDetails: return "userInfo/data"
        case .eLogin: return "loginInfo/data"
        case .eSignUp: return "signUp/data"
        case .ePlaceList: return "s/2iodh4vg0eortkl/facts.json"
        case .eUnknown: return ""
            
      }
    }
    
}
