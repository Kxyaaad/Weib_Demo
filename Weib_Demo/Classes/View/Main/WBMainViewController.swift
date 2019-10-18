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
    }
   
}

extension WBMainViewController {
    private func setupChildControllers() {
        let array = [
            ["clsName":"WBHomeViewController", "title":"首页", "imageName":"home"],
            ["clsName":"WBMessageViewController", "title":"消息", "imageName":"xiaoxi"],
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
        vc.tabBarItem.image = UIImage(named: imageName)
        let nav = WBNavigationViewController(rootViewController: vc)
        return nav
    }
    
    
}
