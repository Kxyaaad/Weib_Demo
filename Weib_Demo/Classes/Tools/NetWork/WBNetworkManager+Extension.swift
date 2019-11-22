//
//  WBNetworkManager+Extension.swift
//  Weib_Demo
//
//  Created by SanDisk on 2019/11/21.
//  Copyright © 2019 SanDisk. All rights reserved.
//

import Foundation

//since_id: 下拉刷新是需要的最上面一条微博的ID，默认为0
//max_id: 上拉加载时，最下面一条微博的ID，默认为0

extension WBNetworkManager {
    
    func statusList(since_id:Int64 = 0, max_id:Int64 = 0, completion:@escaping (_ list:[[String:Any]]?, _ isSuccess:Bool)->()) {
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        let parameters = ["since_id":since_id, "max_id":max_id]
       
        
        tokenRequest(Method: .GET, URLString: urlString, parameter: parameters) { (json, bool) in
           
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
