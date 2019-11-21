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
        request(Method: .GET, URLString: urlString, parameter: ["access_token":"2.00YWlWBHJj2S5D05171bc783dOKFBB"]) { (json, bool) in
           
            let list = (json as! [String:Any])["statuses"] as! [[String:Any]]
            let isSuccess = bool
//            print("最终结果", list)
            completion(list, isSuccess)
        }
        
    }
}
