//
//  WBBaseViewController.swift
//  Weib_Demo
//
//  Created by SanDisk on 2019/10/14.
//  Copyright © 2019 SanDisk. All rights reserved.
//

import UIKit

class WBBaseViewController: UIViewController{
    
    var isLogon = true
    
    //访客视图信息字典
    var visitorInfoDictionary: [String:String]?
    
    var tableView : UITableView?
    var refreshControl: UIRefreshControl?
    
    @objc func loadData(isPullup:Bool) {
        //如果子类不实现任何方法，则关闭刷新动画
        refreshControl?.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("加载页面")
        setUpUI()
        // Do any additional setup after loading the view.
        
        //注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(loginSuccess(Noti:)), name: NSNotification.Name(rawValue: WBUserLoginSuccessedNotification), object: nil)
    }
    
    deinit {
        //注销通知
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func login() {
        print("登录")
        //发送通知
        NotificationCenter.default.post(name: Notification.Name(WBUserShouldLoginNotification), object: nil)
    }
    
    @objc private func regist() {
        
    }
    
}

extension WBBaseViewController {
    
    //登录成功处理
    @objc private func loginSuccess(Noti: Notification) {
        print("登录成功\(Noti)")
        navigationItem.leftBarButtonItem = nil
        navigationItem.rightBarButtonItem = nil
        //更新UI => 将访客视图替换为表格视图
        //需要重新设置View
        view = nil
        
        //注销通知
        NotificationCenter.default.removeObserver(self)
        
    }
    
    
    @objc func setUpUI() {
        print("加载页面2")
        view.backgroundColor = UIColor.cz_random()
        print("是否登录",WBNetworkManager.shared.userLogon)
        isLogon = WBNetworkManager.shared.userLogon
        WBNetworkManager.shared.userLogon ? loadData(isPullup: false) : ()
        WBNetworkManager.shared.userLogon ? self.setTable() : self.setVisitorView()
        print("加载页面3")
        
    }
    //添加表格视图
    @objc func setTable() {
        print("加载tableview")
        tableView = UITableView(frame: CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height + 44 , width: UIScreen.cz_screenWidth(), height: UIScreen.cz_screenHeight() - (UIApplication.shared.statusBarFrame.height + 44 + (tabBarController?.tabBar.frame.height)!)))
           tableView?.delegate = self
           tableView?.dataSource = self
           tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
           
           //添加刷新攻坚
           refreshControl = UIRefreshControl()
           refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
           tableView?.addSubview(refreshControl!)
           
           view.addSubview(tableView!)
    }
    
    //添加访客视图
    @objc func setVisitorView() {
        print("加载访客视图")
        let visitorView = WBVisitorView(frame: view.bounds)
        view.addSubview(visitorView)
        //设置访客视图信息
        visitorView.visitorInfo = visitorInfoDictionary
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(regist))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(login))
        navigationItem.leftBarButtonItem?.tintColor = .orange
        navigationItem.rightBarButtonItem?.tintColor = .orange
    }
}

extension WBBaseViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
 
