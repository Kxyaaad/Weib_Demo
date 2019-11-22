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
    func loadStatus(isPullup:Bool = false, completion:@escaping (_ isSuccess:Bool)->()) {
        
        let since_id = isPullup ? 0 : statusList.first?.id ?? 0
        let max_id = !isPullup ? 0 : statusList.last!.id-1 ?? 0
        
        WBNetworkManager.shared.statusList(since_id: since_id, max_id: max_id) { (list, isSuccess) in
            //字典转模型
            guard let array  = NSArray.yy_modelArray(with: WBStatus.self, json: list ?? []) as? [WBStatus] else {
                completion(isSuccess)
                return
            }
            
            //拼接数据
            if isPullup {
                //上拉刷新，将数组拼接在末尾
                self.statusList += array
            }else {
                //下拉刷新时，应该拼接数组
                self.statusList = array + self.statusList
            }
            
            
            
            //完成回调
            completion(isSuccess)
        }
    }
}
