//
//  WBNetworkManager.swift
//  Weib_Demo
//
//  Created by SanDisk on 2019/11/19.
//  Copyright © 2019 SanDisk. All rights reserved.
//

import UIKit
import AFNetworking


enum WBHTTPMethod {
    case GET
    case POST
}

class WBNetworkManager: AFHTTPSessionManager {
    
    ///封装AFN的GET/POST请求
    static let shared = WBNetworkManager()
    
    
    //使用一个函数封装GET/POST请求
    
    func request(Method:WBHTTPMethod, URLString: String, parameter:[String:Any], completion: @escaping (_ json:Any?, _ isSuccess:Bool)->() ) {
        
        switch Method {
        case .GET:
            get(URLString, parameters: parameter, progress: nil, success: { (URLSessionDataTask, json) -> () in
                completion(json, true)
            }) { (URLSessionDataTask, error) -> () in
                completion(error, false)
            }
        default:
            post(URLString, parameters: parameter, progress: nil, success: { (URLSessionDataTask, json) -> () in
                completion(json, true)
            }) { (URLSessionDataTask, error) in
                completion(error, false)
            }
        }
    }
}
