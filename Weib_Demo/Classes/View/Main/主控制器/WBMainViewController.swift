//
//  WBMainViewController.swift
//  Weib_Demo
//
//  Created by SanDisk on 2019/10/14.
//  Copyright © 2019 SanDisk. All rights reserved.
//

import UIKit
import SVProgressHUD

class WBMainViewController: UITabBarController {
    var timer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()

        setupChildControllers()
        setupComposeButton()
        setupNewFeatureViews()
        self.tabBar.tintColor = UIColor.orange
        UIApplication.shared.applicationIconBadgeNumber = 4
        
        delegate = self
        //注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(userLogin(n:)), name: Notification.Name(WBUserShouldLoginNotification), object: nil)
    }
    
    deinit {
        //注销卷筒纸
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: -私有控件
    private lazy var composeButton: UIButton = UIButton.cz_imageButton("tabbar_compose_icon_add", backgroundImageName: "tabbar_compose_button")
   
    //MARK: - 监听方法
    @objc func composeStatus() {
        let vc = UIViewController()
//        vc.modalPresentationStyle = .fullScreen
        vc.view.backgroundColor = UIColor.cz_random()
        present(vc, animated: true, completion: nil)
    }
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    @objc private func userLogin(n:Notification) {
//        print(n)
        if n.object != nil {
//            SVProgressHUD.showError(withStatus: "登录身份过期，请重新登录")
            SVProgressHUD.showInfo(withStatus: "登录身份过期，请重新登录")
       
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                let vc = WBOAuthViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
        
        }else {
            let vc = WBOAuthViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
       
    }
    
}

//MARK: 设置TabBar代理
extension WBMainViewController:UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let index  = tabBarController.viewControllers?.firstIndex(of: viewController)
        //如果在已经在首页，再点击则自动滑动到顶部
        if selectedIndex == index && selectedIndex == 0 {
            let nav = children[0] as! UINavigationController
            let vc = nav.children[0] as! WBHomeViewController
           
            vc.tableView?.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
//                print("开始加载")
                vc.refreshControl?.beginRefreshing()
                vc.loadData()
            }
        }
        
        if viewController == tabBarController.viewControllers![2] {
            return false
        }else {
            return true
        }
    
        
    }
}

//MARK: 设置界面

extension WBMainViewController {
    
    private func setupComposeButton() {
        
        
        let count = CGFloat(children.count)
        let w = tabBar.bounds.width / count
    
        composeButton.frame = tabBar.bounds.insetBy(dx: 2 * w, dy: 0)
        tabBar.addSubview(composeButton)
        
        composeButton.addTarget(self, action: #selector(composeStatus), for: .touchUpInside)
        
    }
    
    private func setupChildControllers() {
        //获取沙盒的文件路径
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let jsonPath = (docDir as NSString).appendingPathComponent("main.json")
//        print("沙盒路径", jsonPath)
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

/// MARK: - 新特性视图处理
extension WBMainViewController {
    private func setupNewFeatureViews() {
        
        //检查版本是否更新
        
        
        // 如果更新，显示新特性，否则显示欢迎视图
        let v = isNewVersion ? WBNewFeatureView() : WBWelcomView()
        v.frame = view.bounds
        // 添加视图
        view.addSubview(v)
        
    }
    /// extension中可以有计算型属性
    private var isNewVersion:Bool {
        
        //1、取当前版本号
        let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        //2、取保存在’Document（iTunes备份）‘目录中的之前版本号
        let path: String = ("version" as NSString).cz_appendDocumentDir()
        let sandboxVersion = try? String(contentsOfFile: path)
        print( "本地版本",sandboxVersion, path)
        
        //3、将当前版本号保存在沙盒
        try? currentVersion.write(toFile: path, atomically: true, encoding: .utf8)
        
        return currentVersion != sandboxVersion
    }
}
