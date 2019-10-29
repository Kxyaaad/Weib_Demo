//
//  WBBaseViewController.swift
//  Weib_Demo
//
//  Created by SanDisk on 2019/10/14.
//  Copyright © 2019 SanDisk. All rights reserved.
//

import UIKit

class WBBaseViewController: UIViewController{
    
    var isLogon = false
    
    var tableView : UITableView?
    var refreshControl: UIRefreshControl?
    
    @objc func loadData() {
        //如果子类不识闲任何方法，则关闭刷新动画
        refreshControl?.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        // Do any additional setup after loading the view.
    }
    
}

extension WBBaseViewController {
    @objc func setUpUI() {
        view.backgroundColor = UIColor.cz_random()
        isLogon ? setTable() : setVisitorView()
       
        loadData()
    }
    //添加表格视图
    @objc func setTable() {
        
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
        let visitorView = UIView(frame: view.bounds)
        visitorView.backgroundColor = UIColor.cz_random()
        view.addSubview(visitorView)
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
 
