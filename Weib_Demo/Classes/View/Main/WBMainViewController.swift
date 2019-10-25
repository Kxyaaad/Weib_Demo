//
//  WBMainViewController.swift
//  Weib_Demo
//
//  Created by SanDisk on 2019/10/14.
//  Copyright © 2019 SanDisk. All rights reserved.
//

import UIKit

class WBMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupChildControllers()
        setupComposeButton()
        self.tabBar.tintColor = UIColor.orange
        
    }
    
    //MARK: -私有控件
    private lazy var composeButton: UIButton = UIButton.cz_imageButton("tianjia", backgroundImageName: "tianjia")
   
    //MARK: - 监听方法
    @objc func composeStatus() {
        
    }
}

//MARK: 设置界面

extension WBMainViewController {
    
    private func setupComposeButton() {
        let count = CGFloat(children.count)
        let w = tabBar.bounds.width / count - 1
    
        composeButton.frame = tabBar.bounds.insetBy(dx: 2 * w, dy: 0)
        tabBar.addSubview(composeButton)
        
        composeButton.addTarget(self, action: #selector(composeStatus), for: .touchUpInside)
        
    }
    
    private func setupChildControllers() {
        let array = [
            ["clsName":"WBHomeViewController", "title":"首页", "imageName":"home"],
            ["clsName":"WBMessageViewController", "title":"消息", "imageName":"xiaoxi"],
            ["clsName":"*", "title":"", "imageName":"tianjia"],
            ["clsName":"WBDiscoverViewController", "title":"发现", "imageName":"sousuo"],
            ["clsName":"WBProfileViewController", "title":"我", "imageName":"wo"]
        ]
        
        var arrayM = [UIViewController]()
        for dict in array {
            arrayM.append(controller(dict: dict))
        }
        
        viewControllers = arrayM
    }
    
    // parameter dict: 信息字典[clsName, title, imageName]
    private func controller(dict:[String: String]) -> UIViewController {
        guard let clsName = dict["clsName"], let title = dict["title"], let imageName = dict["imageName"], let cls = NSClassFromString(Bundle.main.namespace + "." + clsName) as? UIViewController.Type
            else { return UIViewController() }
        
        let vc = cls.init()
        vc.title = title
        //标题图片
        vc.tabBarItem.image = UIImage(named: imageName)
        //标题字体
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.orange], for: .highlighted)
        let nav = WBNavigationViewController(rootViewController: vc)
        return nav
    }
    
    
}
