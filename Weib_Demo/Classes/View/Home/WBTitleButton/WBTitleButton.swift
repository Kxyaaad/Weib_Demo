//
//  WBTitleButton.swift
//  Weib_Demo
//
//  Created by Mac on 2020/1/17.
//  Copyright © 2020 SanDisk. All rights reserved.
//

import UIKit

class WBTitleButton: UIButton {
    
    //重载构造函数
    /// title为nil， 就显示“首页”
    /// title部位nil， 就显示title和箭头图像
    init(title: String?) {
        super.init(frame: CGRect())
        
        if title == nil {
            setTitle("首页", for: [])
        }else {
            titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
            setTitleColor(.darkGray, for: [])
            setTitle(title, for: [])
            setImage(UIImage?.init(UIImage(named: "navigationbar_arrow_down")!), for: .normal)
            setImage(UIImage?.init(UIImage(named: "navigationbar_arrow_up")!), for: .selected)
            sizeToFit()
        }
        
        
    }
    ///重新布局子视图
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //判断lable和imageView是否同时存在
        guard let titleLable = titleLabel, let imageView = imageView else { return }
   
        titleLable.frame = CGRect(x: 0, y: (titleLabel?.frame.origin.y)!, width: (titleLabel?.frame.width)!, height: titleLabel?.frame.height ?? 0)
        imageView.frame = CGRect(x: (titleLabel?.frame.width)! + 3, y: imageView.frame.origin.y, width: (imageView.frame.width), height: (imageView.frame.height))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
