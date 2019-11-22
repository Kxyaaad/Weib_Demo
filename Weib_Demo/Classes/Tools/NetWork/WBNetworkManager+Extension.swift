//
//  WBNetworkManager+Extension.swift
//  Weib_Demo
//
//  Created by SanDisk on 2019/11/21.
//  Copyright © 2019 SanDisk. All rights reserved.
//

import Foundation

extension WBNetworkManager {
    
    func statusList(completion:@escaping (_ list:[[String:Any]]?, _ isSuccess:Bool)->()) {
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        
       
        
        tokenRequest(Method: .GET, URLString: urlString, parameter: nil) { (json, bool) in
           
            if bool == true {
                let list = (json as! [String:Any])["statuses"] as! [[String:Any]]
                            let isSuccess = bool
                //            print("最终结果", list)
                            completion(list, isSuccess)
            }else {
//                print(json)
            }
            
        }
        
    }
}
