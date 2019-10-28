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

    private lazy var statusList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func loadData() {
        for i in 0..<10 {
            statusList.insert(i.description, at: 0)
        }
        refreshControl?.endRefreshing()
    }
    

    @objc func showFriends() {
        let vc = WBDemoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension WBHomeViewController {
    override func setUpUI() {
        super.setUpUI()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(showFriends))
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
}

extension WBHomeViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = statusList[indexPath.row]
        return cell
    }
}
