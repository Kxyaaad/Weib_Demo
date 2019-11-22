//
//  WBStatus.swift
//  Weib_Demo
//
//  Created by SanDisk on 2019/11/21.
//  Copyright © 2019 SanDisk. All rights reserved.
//

import UIKit
import YYModel
//微博数据模型
class WBStatus: NSObject {
    
    @objc var id:Int64 = 0 //微博ID
    var text:String = "" //微博信息内容
    var source:String = "" //信息来源
    
    //重写计算型属性
    override var description: String {
        return yy_modelDescription()
    }
}
