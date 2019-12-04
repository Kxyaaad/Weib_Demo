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

        self.refreshControl?.addTarget(self, action: #selector(loadData(isPullup:)), for: .valueChanged)
    }
    
    override func loadData(isPullup:Bool = false) {
        
        listViewModel.loadStatus(isPullup: isPullup) { (success, hasMorePullup) in
            self.refreshControl?.endRefreshing()
            if hasMorePullup {
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.listViewModel.statusList.count - 4{
            self.loadData(isPullup: true)
        }
    }
}
