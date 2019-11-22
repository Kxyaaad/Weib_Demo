//
//  WBHomeViewController.swift
//  Weib_Demo
//
//  Created by SanDisk on 2019/10/14.
//  Copyright © 2019 SanDisk. All rights reserved.
//

import UIKit

private let cellID = "cellID"

class WBHomeViewController: WBBaseViewController {

    private lazy var listViewModel = WBStatusListModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
    }
    
    override func loadData() {
        
        listViewModel.loadStatus { (isSuccess) in
            //
            print("cell个数", self.listViewModel.statusList.count)
            if isSuccess == true {
                self.refreshControl?.endRefreshing()
                self.tableView?.reloadData()
            }
        }
        
        
    }
    

    @objc func showFriends() {
        let vc = WBDemoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension WBHomeViewController {
    override func setUpUI() {
        super.setUpUI()
//        super.setTable()
        super.isLogon ? navigationItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(showFriends)) : nil
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
}

extension WBHomeViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = self.listViewModel.statusList[indexPath.row].text + "."
        print("文字内容",self.listViewModel.statusList[indexPath.row].text)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.listViewModel.statusList.count - 1 {
            self.loadData()
        }
    }
}
