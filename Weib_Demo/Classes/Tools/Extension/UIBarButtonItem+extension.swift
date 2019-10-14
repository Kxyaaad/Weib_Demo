//
//  UIBarButtonItem+extension.swift
//  XtWeiBo
//
//  Created by 徐腾 on 2017/7/19.
//  Copyright © 2017年 徐腾. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    /// 便利构造函数 自定义UIBarButtonItem
    ///
    /// - Parameters:
    ///   - title: title
    ///   - fontSize: fontSize 默认 16 号
    ///   - target: target
    ///   - action: action
    ///   - isBack: 是否是返回按钮，默认不是返回按钮
    convenience init(title: String, fontSize: CGFloat = 16, target: AnyObject, action: Selector, isBack: Bool = false) {
        
        // 创建btn
        let btn: UIButton = UIButton.cz_textButton(title, fontSize: 16, normalColor: UIColor.darkGray, highlightedColor: UIColor.orange)
        
        if isBack == true {
            let imageName = "navigationbar_back_withtext"
            btn.setImage(UIImage.init(named: imageName), for: .normal)
            btn.setImage(UIImage.init(named: imageName + "_highlighted"), for: .highlighted)
            btn.sizeToFit()
        }
        
        btn.addTarget(target, action: action, for: .touchUpInside)
        
        self.init(customView: btn)
    }
    
}
