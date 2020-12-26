//
//  Network.swift
//  GitHistory
//
//  Created by chenyh on 2020/12/27.
//

import UIKit
import Alamofire

typealias CXResultBlock = (CXResponse) -> Void

struct CXDecoder {
    static func decode<T>(_ type: T.Type, param: [String: Any]) -> T? where T: Decodable {
        guard let json = self.getJson(with: param) else {
            return nil
        }
        guard let model = try? JSONDecoder().decode(type, from: json) else {
            return nil
        }
        return model
    }

    static func decode<T>(_ type: T.Type, array: [[String: Any]]) -> [T]? where T: Decodable {
        guard let data = self.getJson(with: array) else {
            print("decode convert \(array.description)")
            return nil
        }
        var models: [T] = []
        do {
           models = try JSONDecoder().decode([T].self, from: data)
        } catch {
            print(error)
        }
        return models
    }

    static func getJson(with param: Any) -> Data? {
        if !JSONSerialization.isValidJSONObject(param) {
            return nil
        }
        do {
            return try JSONSerialization.data(withJSONObject: param, options: [])
        } catch {
            print(error)
            return nil
        }
    }
}

struct CXResponse {
    let error: NSError?
    let data: Any?

    init(error: NSError?, data: Any?) {
        self.error = error
        self.data = data
    }
}

enum CXHttpMethed {
    case GET
    case POST
}

class CXNetwork {
    
    class func request(url: String, methed: CXHttpMethed = .GET, params: Parameters? = nil, handler: @escaping CXResultBlock) {
        let method_ = methed == .GET ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(url, method: method_, parameters: params).response { (response: DefaultDataResponse) in
            guard response.response != nil else {
                let error = hasError(message: "reponse is nil")
                let r = CXResponse(error: error, data: nil)
                handler(r)
                return
            }

            guard let jsonData = try? JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers) else {
                print("JSONSerialization failed")
                return
            }

            guard let mapData = jsonData as? [String: Any] else {
                let result: String = String(data: response.data!, encoding: .utf8) ?? "empty"
                print("convert to mapData faild:\nurl: \(url)\nparameters: \(params ?? [:])\ndata: \(result)")
                return
            }

            handlerData(mapData: mapData, handler: handler)
        }
    }
    
    private static func handlerData(mapData: [String: Any], handler: @escaping CXResultBlock) {
        var code: Int = 0
        var error: NSError?
        var data: Any?
        if mapData.keys.contains("code") {
            code = mapData["code"] as! Int
            if code == 200 {
                data = mapData["data"]
            } else {
                let msg = mapData["error"] as! String
                error = hasError(message: msg)
            }
        } else if mapData.keys.contains("status") {
            code = mapData["status"] as! Int
            if code == 400 {
                error = hasError(message: mapData["message"] as! String)
            }
        } else {
            data = mapData
        }

        let result = CXResponse(error: error, data: data)
        handler(result)
    }
    
    static func hasError(code: Int = -1, message: String) -> NSError {
        return NSError(domain: "", code: code, userInfo: ["message": message])
    }
}


