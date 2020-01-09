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
    static let shared: WBNetworkManager = {
        let instance = WBNetworkManager()
        
        //设置响应反序列化支持的数据类型
        instance.responseSerializer.acceptableContentTypes?.insert("text/plain")
        
        return instance
    }()
   
    lazy var userAccount = WBUserAccount()
    
    lazy var userLogon = (userAccount.access_token != nil) ? true : false
    
    //负责拼接token的网络请求
    func tokenRequest(Method:WBHTTPMethod, URLString: String, parameter:[String:Any]?, completion: @escaping (_ json:Any?, _ isSuccess:Bool)->()) {
        
        //如果accessToken为nil,则直接返回
        guard userAccount.access_token != nil else { return
            //通知进行登录
            NotificationCenter.default.post(name: NSNotification.Name(WBUserShouldLoginNotification), object: "fe")
            
            completion(nil, false)
        }
        //如果为nil，则新建一个字典
        var parameter = parameter
        if parameter == nil {
            parameter = [String:Any]()
        }
        parameter!["access_token"] = userAccount.access_token
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
                //通知进行登录
                NotificationCenter.default.post(name: NSNotification.Name(WBUserShouldLoginNotification), object: "nil")
            
                //失败回调
//                print("错误信息",error)
                completion(nil, false)
                
            }
        default:
            post(URLString, parameters: parameter, progress: nil, success: { (URLSessionDataTask, json) -> () in
                completion(json, true)
            }) { (URLSessionDataTask, error) in
                //通知进行登录
                NotificationCenter.default.post(name: NSNotification.Name(WBUserShouldLoginNotification), object: "nil")
                completion(nil, false)
            }
        }
    }
}
