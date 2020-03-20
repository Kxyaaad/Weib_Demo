//
//  WBWelcomeView.swift
//  Weib_Demo
//
//  Created by Mac on 2020/1/17.
//  Copyright © 2020 SanDisk. All rights reserved.
//


import UIKit

/// 欢迎视图
class WBWelcomView: UIView {
    
    class func welcome()-> WBWelcomView {
        let nib = UINib(nibName: "WBWelcomeView", bundle: nil)
        let v = nib.instantiate(withOwner: nil, options: nil)[0]
        return v as! WBWelcomView
    }
}
