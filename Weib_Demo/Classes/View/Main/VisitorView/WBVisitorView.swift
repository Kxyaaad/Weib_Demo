//
//  WBVisitorView.swift
//  Weib_Demo
//
//  Created by SanDisk on 2019/10/29.
//  Copyright © 2019 SanDisk. All rights reserved.
//

import UIKit

class WBVisitorView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //私有控件
    private lazy var iconView = UIImageView(image: UIImage(named: "jiazaizhong"))
    
    private lazy var houseiconView = UIImageView(image: UIImage(named: "home-1"))
    
    private lazy var tipLabel = UILabel.cz_label(withText: "关注一些人，回这里看看有什么惊喜", fontSize: 14, color: .darkGray)

    private lazy var registerButton : UIButton = UIButton.cz_textButton("注册", fontSize: 16, normalColor: .orange, highlightedColor: .black)
    
    private lazy var loginButton : UIButton = UIButton.cz_textButton("登录", fontSize: 16, normalColor: .darkGray, highlightedColor: .black)
}

extension WBVisitorView{
    func setupUI() {
        backgroundColor = UIColor.white
        
        //添加控件
        addSubview(iconView)
        addSubview(houseiconView)
        addSubview(registerButton)
        addSubview(loginButton)
        
        //取消autoresizing
        for v in subviews {
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        //纯代码自动布局
        addConstraint(NSLayoutConstraint(item: iconView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: iconView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: houseiconView, attribute: .centerX, relatedBy: .equal, toItem: iconView, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: houseiconView, attribute: .centerY, relatedBy: .equal, toItem: iconView, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
