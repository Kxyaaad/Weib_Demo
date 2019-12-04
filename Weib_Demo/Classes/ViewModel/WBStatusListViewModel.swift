//
//  WBStatusListViewModel.swift
//  Weib_Demo
//
//  Created by SanDisk on 2019/11/22.
//  Copyright © 2019 SanDisk. All rights reserved.
//

import Foundation

//上拉刷新最大尝试次数
private let maxPullpuTryTimes = 3

//微博数据列表视图模型
class WBStatusListModel:WBStatus {
    //微博模型数组
    lazy var statusList = [WBStatus]()
    
    //上拉刷新错误次数
    private var pullupErrorTimes = 0
    //加载微博列表, hasMorePullup是否有更多的上拉刷新
    func loadStatus(isPullup:Bool = false, completion:@escaping (_ isSuccess:Bool, _ hasMorePullup:Bool)->()) {
        
        //判断是否上拉刷新，检查刷新错误
        if isPullup && pullupErrorTimes > maxPullpuTryTimes {
            completion(true, false)
            return
        }
        let since_id = isPullup ? 0 : statusList.first?.id ?? 0
        let max_id = !isPullup ? 0 : statusList.last!.id-1 ?? 0
        
        WBNetworkManager.shared.statusList(since_id: since_id, max_id: max_id) { (list, isSuccess) in
            //字典转模型
            guard let array  = NSArray.yy_modelArray(with: WBStatus.self, json: list ?? []) as? [WBStatus] else {
                completion(isSuccess, false)
                return
            }
            
            //拼接数据
            if isPullup {
                //上拉刷新，将数组拼接在末尾
                self.statusList += array
            }else {
                //下拉刷新时，应该拼接数组在头部
                self.statusList = array + self.statusList
            }
            
            // 判断上拉刷新数据量
            if isPullup && array.count == 0 {
                self.pullupErrorTimes += 1
                completion(isSuccess, false)
            }else {
                //完成回调
                completion(isSuccess, true)
            }
            
            
        }
    }
}
