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
    
    //封装AFN的GET/POST请求
    static let shared = WBNetworkManager()
    //访问令牌
    var accessToken: String? = "2.00YWlWBH00R1W88b6e4c948aL5gDSC"
    
    
    //负责拼接token的网络请求
    func tokenRequest(Method:WBHTTPMethod, URLString: String, parameter:[String:Any]?, completion: @escaping (_ json:Any?, _ isSuccess:Bool)->()) {
        
        //如果accessToken为nil,则直接返回
        guard accessToken != nil else { return
            completion(nil, false)
        }
        //如果为nil，则新建一个字典
        var parameter = parameter
        if parameter == nil {
            parameter = [String:Any]()
        }
        parameter!["access_token"] = accessToken
        //调用request发起真正的网络请求方法
        request(Method: Method, URLString: URLString, parameter: parameter, completion: completion)
    }
    
    
    
    //使用一个函数封装GET/POST请求
    
    func request(Method:WBHTTPMethod, URLString: String, parameter:[String:Any]?, completion: @escaping (_ json:Any?, _ isSuccess:Bool)->() ) {
        
        switch Method {
        case .GET:
            get(URLString, parameters: parameter, progress: nil, success: { (URLSessionDataTask, json) -> () in
                completion(json, true)
            }) { (task, error) -> () in
               //针对403处理用户token过期
                if (task?.response as? HTTPURLResponse)?.statusCode == 403 {
                    print("token过期")
                }
            
                //失败回调
//                print("错误信息",error)
                completion(nil, false)
            }
        default:
            post(URLString, parameters: parameter, progress: nil, success: { (URLSessionDataTask, json) -> () in
                completion(json, true)
            }) { (URLSessionDataTask, error) in
                completion(nil, false)
            }
        }
    }
}
