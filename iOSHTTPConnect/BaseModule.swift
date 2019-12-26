//
//  BaseModule.swift
//  NTS
//
//  Created by Ashish Awasthi on 20/03/19.
//  Copyright © 2019 NTS. All rights reserved.
//
import Foundation

private let ContentType = "Content-Type"
private let ContentTypeValue = "application/json"


public let kRespData = "data"
public let KRespJson = "json"
public let kRespStr = "string"
public let kResponse = "response"

class BaseModule {
    
    internal func processRequest(requestForm: RequestForm, completeRequest: @escaping (_ result: Result<Data>) -> Void)  {
    }
    
    internal func requestForData(fromUrl url: String, withMethod methodName: String, successHandler: @escaping(_ data: Data?, _ error: Error?)->Void)  {
        //Implementing URLSession
        guard let url = URL(string: url) else { return }
        //var header = self.headers
        let defaultSession = URLSession(configuration: .ephemeral)
        var request = URLRequest(url: url)
        request.addValue(ContentTypeValue, forHTTPHeaderField: ContentType)
        request.httpMethod = methodName
        defaultSession.dataTask(with: request) { (data, response, error) in
            if let errorItem = error {
                FSLogError(errorItem.localizedDescription)
                successHandler(nil, error)
            }
            guard let data = data else { return }
            self.getValidDataObject(from: data, complete: { (validData, parseError) in
                successHandler(validData,parseError)
            })
        }.resume()
    }
    
    public func getJsonObject(fromData data: Data, parseHandler: @escaping(_ json: Any?, _ error: Error?)-> Void )  {
        do {
            if let jsonDict = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                parseHandler(jsonDict,nil)
            } else if let jsonArray = try JSONSerialization.jsonObject(with:data, options: [.mutableContainers, .allowFragments]) as? Array<Any> {
                parseHandler(jsonArray,nil)
                FSLogInfo("JSON:- \(String(describing: jsonArray))")
            }
        }
        catch let error {
            parseHandler(nil,error)
        }
    }
    
    var headers: [String: String] {
        return ["content-type" : "application/json","auth": ModelController.shared.accessToken]
    }
    
    func decodeData<JSONElement: Decodable>(raw data: Data, withType type: JSONElement.Type, processComplete: @escaping(_ model: JSONElement?, _ error: Error?)->Void) {
        do {
            let model = try JSONDecoder().decode(JSONElement.self, from: data)
            processComplete(model,nil) }
        catch let error {
            processComplete(nil,error)
        }
    }
    func getValidDataObject(from data: Data, complete: @escaping(_ data: Data? , _ error: Error?) ->Void) {
        if JSONSerialization.isValidJSONObject(data) {
            complete(data, nil)
        } else {
            do {
                if let serverStr = String.init(data: data, encoding: String.Encoding.ascii) {
                    FSLogError("Not getting valid Json from API")
                    let asciiData = serverStr.data(using: String.Encoding.utf8, allowLossyConversion: true)
                    complete(asciiData, nil)
                    let  json = try JSONSerialization.jsonObject(with: asciiData!, options: JSONSerialization.ReadingOptions()) as? [String: AnyObject]
                    FSLogInfo("Converting Invalid to Valid\(String(describing: json))")
                }
                
            } catch let error {
                FSLogError(error.localizedDescription)
                complete(nil, error)
            }
            
            
        }
        
    }
    
}

