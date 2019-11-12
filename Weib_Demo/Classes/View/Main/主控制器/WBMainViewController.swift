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
    private lazy var composeButton: UIButton = UIButton.cz_imageButton("tabbar_compose_icon_add", backgroundImageName: "tabbar_compose_button")
   
    //MARK: - 监听方法
    @objc func composeStatus() {
        let vc = UIViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.view.backgroundColor = UIColor.cz_random()
        present(vc, animated: true, completion: nil)
    }
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
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
//        let array : [[String:Any]] = [
//            ["clsName":"WBHomeViewController", "title":"首页", "imageName":"tabbar_home", "visitorInfo":["imageName":"", "message":"关注一些人，回来看看有什么惊喜"]],
//            ["clsName":"WBMessageViewController", "title":"消息", "imageName":"tabbar_message_center", "visitorInfo":["imageName":"visitordiscover_image_message", "message":"登录后，别人评论你的微博，发给你的消息，都会在这里收到通知"]],
//            ["clsName":"*", "title":"", "imageName":"tianjia", "visitorInfo":["imageName":"", "message":"测试"]	],
//            ["clsName":"WBDiscoverViewController", "title":"发现", "imageName":"tabbar_discover", "visitorInfo":["imageName":"visitordiscover_image_message", "message":"登录后，最新、最热微博尽在掌握，不再会与实事潮流擦肩而过"]],
//            ["clsName":"WBProfileViewController", "title":"我", "imageName":"tabbar_profile", "visitorInfo":["imageName":"visitordiscover_image_profile", "message":"登录后，你的微博、相册、个人资料会显示在这里，展示给别人"]]
//        ]
        
//        if let path = Bundle.main.path(forResource: "main", ofType: "json") {
//            print("文件存在")
//        }else{
//            print("文件不存在")
//        }
        
        //从bundle加载配置的json
        guard let path = Bundle.main.path(forResource: "main", ofType: "json"),
            let data = NSData(contentsOfFile: path), let array = try? JSONSerialization.jsonObject(with: data as Data, options: []) as? [[String:Any]] else { return }
        
        
//        let data = try! JSONSerialization.data(withJSONObject: array, options: [.prettyPrinted])
//        (data as NSData).write(toFile: "/Users/sandisk/Desktop/Demos/Weib_Demo/Weib_Demo/Classes/View/Main/主控制器/main.json", atomically: true)
        
        var arrayM = [UIViewController]()
        for dict in array {
            arrayM.append(controller(dict: dict))
        }
        
        viewControllers = arrayM
    }
    
    // parameter dict: 信息字典[clsName, title, imageName]
    private func controller(dict:[String: Any]) -> UIViewController {
        guard let clsName = dict["clsName"] as? String, let title = dict["title"] as? String, let imageName = dict["imageName"] as? String, let cls = NSClassFromString(Bundle.main.namespace + "." + clsName) as? WBBaseViewController.Type,let visitorDict = dict["visitorInfo"] as? [String:String]
            else { return UIViewController() }
        
        let vc = cls.init()
        vc.title = title
        
        vc.visitorInfoDictionary = visitorDict
        //标题图片
        vc.tabBarItem.image = UIImage(named: imageName)
        //标题字体
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.orange], for: .highlighted)
        let nav = WBNavigationViewController(rootViewController: vc)
        return nav
    }
    
    
}
