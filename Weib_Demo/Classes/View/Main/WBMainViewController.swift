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
            ["clsName":"", "title":"首页", "imageName":""]
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
        let nav = WBNavigationViewController(rootViewController: vc)
        return nav
    }
    
    
}
