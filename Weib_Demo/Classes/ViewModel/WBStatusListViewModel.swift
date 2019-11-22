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
        
        let since_id = statusList.first?.id ?? 0
        
        WBNetworkManager.shared.statusList(since_id: since_id, max_id: 0) { (list, isSuccess) in
            //字典转模型
            guard let array  = NSArray.yy_modelArray(with: WBStatus.self, json: list ?? []) as? [WBStatus] else {
                completion(isSuccess)
                return
            }
            
            //拼接数据
            //下拉刷新时，应该拼接数组
            self.statusList = array + self.statusList
            
            //完成回调
            completion(isSuccess)
        }
    }
}
