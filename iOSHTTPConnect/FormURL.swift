//
//  FromURL.swift
//  NTS
//
//  Created by Ashish Awasthi on 20/03/19.
//  Copyright © 2019 NTS. All rights reserved.
//
import Foundation

internal enum RequestInviromentBaseURL: Int {
    case eDev = 0 /* Development url which will for develment request*/
    case eQA
    case eProd
}

extension RequestInviromentBaseURL: CaseIterable {
    
    internal func prettyURL(module: RequestServiceModuleType) -> String {
        switch module {
        case .eBase:
            switch self {
            case .eDev: return "https://jsonplaceholder.typicode.com/photos"
            case .eQA:  return "https://jsonplaceholder.typicode.com/photos"
            case .eProd: return "https://jsonplaceholder.typicode.com/photos"
            }
        case .ePhotos:
            switch self {
            case .eDev: return "https://jsonplaceholder.typicode.com/photos"
            case .eQA:  return "https://jsonplaceholder.typicode.com/photos"
            case .eProd: return "https://jsonplaceholder.typicode.com/photos"
            }
        case .ePlaces:
            switch self {
            case .eDev: return "https://dl.dropboxusercontent.com/"
            case .eQA:  return "https://dl.dropboxusercontent.com/"
            case .eProd: return "https://dl.dropboxusercontent.com/"
            }
            case .eMyAccount:
            switch self {
            case .eDev: return "https://test-api.nevaventures.com/"
            case .eQA:  return "https://test-api.nevaventures.com/"
            case .eProd: return "https://test-api.nevaventures.com/"
            }
            case .eMovieInfo:
            switch self {
             case .eDev: return "https://api.myjson.com/bins/"
             case .eQA:  return "https://api.myjson.com/bins/"
             case .eProd: return "https://api.myjson.com/bins/"
                      }
        }
        
    }
}

extension RequestInviromentBaseURL {
 public static var requestInvBaseURL: RequestInviromentBaseURL = .eDev
}
