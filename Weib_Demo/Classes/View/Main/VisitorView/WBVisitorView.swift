//
//  WBVisitorView.swift
//  Weib_Demo
//
//  Created by SanDisk on 2019/10/29.
//  Copyright © 2019 SanDisk. All rights reserved.
//

import UIKit

class WBVisitorView: UIView {

    var visitorInfo: [String:String]? {
        didSet {
            //取字典
            guard let imageName = visitorInfo?["imageName"], let message = visitorInfo?["message"] else {
                return
            }
            
            tipLabel.text = message
            
            if imageName == "" {
                return
            }
            
            iconView.image = UIImage(named: imageName)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    
    //私有控件
    private lazy var iconView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    
    private lazy var maskIconView : UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
    
    private lazy var houseiconView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    
    private lazy var tipLabel : UILabel = UILabel.cz_label(withText: "关注一些人，回这里看看有什么惊喜", fontSize: 14, color: .darkGray)

    private lazy var registerButton : UIButton = UIButton.cz_textButton("注册", fontSize: 16, normalColor: .orange, highlightedColor: .black, backgroundImageName: "common_button_white_disable")
    
    private lazy var loginButton : UIButton = UIButton.cz_textButton("登录", fontSize: 16, normalColor: .darkGray, highlightedColor: .black, backgroundImageName: "common_button_white_disable")
}

extension WBVisitorView{
    func setupUI() {
        backgroundColor = UIColor.white
        
        //添加控件
        addSubview(iconView)
        addSubview(maskIconView)
        addSubview(houseiconView)
        addSubview(registerButton)
        addSubview(tipLabel)
        addSubview(loginButton)
        
        //取消autoresizing
        for v in subviews {
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let margin: CGFloat = 20.0
        //纯代码自动布局
        addConstraint(NSLayoutConstraint(item: iconView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: iconView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: -60))
        
        addConstraint(NSLayoutConstraint(item: houseiconView, attribute: .centerX, relatedBy: .equal, toItem: iconView, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: houseiconView, attribute: .centerY, relatedBy: .equal, toItem: iconView, attribute: .centerY, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: tipLabel, attribute: .centerX, relatedBy: .equal, toItem: iconView, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: tipLabel, attribute: .top, relatedBy: .equal, toItem: iconView, attribute: .bottom, multiplier: 1, constant: 20))
        addConstraint(NSLayoutConstraint(item: tipLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 236))
  
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: .left, relatedBy: .equal, toItem: tipLabel, attribute: .left, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: .top, relatedBy: .equal, toItem: tipLabel, attribute: .bottom, multiplier: 1, constant: margin))
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100))
        
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: .right, relatedBy: .equal, toItem: tipLabel, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: .top, relatedBy: .equal, toItem: tipLabel, attribute: .bottom, multiplier: 1, constant: margin))
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100))
   
        // 6> 遮罩图像
        // views: 定义 VFL 中的控件名称和实际名称映射关系
        // metrics: 定义 VFL 中 () 指定的常数影射关系
        let viewDict = ["maskIconView": maskIconView,
                        "registerButton": registerButton]
        let metrics = ["spacing": 20]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[maskIconView]-0-|",
            options: [],
            metrics: nil,
            views: viewDict))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[maskIconView]-(spacing)-[registerButton]",
            options: [],
            metrics: metrics,
            views: viewDict))
    }
}
