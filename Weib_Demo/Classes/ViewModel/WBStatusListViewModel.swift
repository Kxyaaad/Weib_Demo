//
//  WBStatusListViewModel.swift
//  Weib_Demo
//
//  Created by SanDisk on 2019/11/22.
//  Copyright © 2019 SanDisk. All rights reserved.
//

import Foundation

//微博数据列表视图模型
class WBStatusListModel:WBStatus {
    //微博模型数组
    lazy var statusList = [WBStatus]()
    //加载微博列表
    func loadStatus(completion:@escaping (_ isSuccess:Bool)->()) {
        WBNetworkManager.shared.statusList { (list, isSuccess) in
            //字典转模型
            guard let array  = NSArray.yy_modelArray(with: WBStatus.self, json: list ?? []) as? [WBStatus] else {
                completion(isSuccess)
                return
            }
            
            //拼接数据
            self.statusList += array
            
            //完成回调
            completion(isSuccess)
        }
    }
}
