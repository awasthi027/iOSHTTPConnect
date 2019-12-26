//
//  RequestMethod.swift
//  iOSHTTPConnect
//
//  Created by Ashish Awasthi on 26/12/19.
//  Copyright © 2019 Ashish Awasthi. All rights reserved.
//

import Foundation

public enum RequestMethodType: Int {
    case eGet = 0
    case ePost
    case ePatch
    case eDelete
    case ePut
}

extension RequestMethodType: CaseIterable {
}

extension RequestMethodType {
    var methodName: String {
        switch self {
        case .eGet: return  "GET"
        case .ePost: return  "POST"
        case .ePatch: return  "PATCH"
        case .eDelete: return  "DELETE"
        case .ePut: return  "PUT"
        }
    }
}
