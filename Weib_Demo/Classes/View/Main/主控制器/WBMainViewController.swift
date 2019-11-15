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
        //获取沙盒的文件路径
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let jsonPath = (docDir as NSString).appendingPathComponent("main.json")
            
        //加载data
        var data = NSData(contentsOfFile: jsonPath)
        
        //判断data是否有内容，
        
        if data == nil {
            let path = Bundle.main.path(forResource: "main", ofType: "json")!
            data = NSData(contentsOfFile: path)
        }
        
        guard let array = try? JSONSerialization.jsonObject(with: data! as Data, options: []) as? [[String:Any]] else { return }
        
        //从bundle加载配置的json
//        guard let path = Bundle.main.path(forResource: "main", ofType: "json"),
//            let data = NSData(contentsOfFile: path), let array = try? JSONSerialization.jsonObject(with: data as Data, options: []) as? [[String:Any]] else { return }
        
        
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
