//
//  WBUserAccount.swift
//  Weib_Demo
//
//  Created by Mac on 2019/12/30.
//  Copyright © 2019 SanDisk. All rights reserved.
//

import Foundation

private let accountFile:NSString = "useraccount.json"

class WBUserAccount: NSObject {
    ///访问令牌
    @objc var access_token:String?
    ///用户代号
    @objc var uid: String?
    ///生命周期
    @objc var expires_in: TimeInterval = 0 {
        didSet{
            expiresDate = Date(timeIntervalSinceNow: expires_in)
        }
    }
    
    @objc var expiresDate : Date?
    
    override var description: String {
        return yy_modelDescription()
    }
    
    override init() {
        super.init()
        //从磁盘加载
        guard let path = accountFile.cz_appendDocumentDir() else { return }
        let data = NSData(contentsOfFile: path)
        
        //使用字典设置属性值
        let dict = try? JSONSerialization.jsonObject(with: data! as Data, options: []) as? [String:Any]
        
        print("读取文件", dict)
        
        self.yy_modelSet(with: dict ?? [:])
    }
    
    func saveAccount() {
        //模型转字典
        var dict = self.yy_modelToJSONObject() as? [String:Any]
        
        //需要删除expires_in的值
        dict?.removeValue(forKey: "expires_in")
        
        //字典序列化
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: []), let fileName  = accountFile.cz_appendDocumentDir() else {return}
        
        print("保存文件名", fileName)
        //写入磁盘
        (data as NSData).write(toFile: fileName, atomically: true)
    }
}