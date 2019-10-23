//
//  WBDemoViewController.swift
//  Weib_Demo
//
//  Created by SanDisk on 2019/10/23.
//  Copyright © 2019 SanDisk. All rights reserved.
//

import UIKit

class WBDemoViewController: WBBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc private func toMsg() {
        let vc = WBMessageViewController()
        navigationController?.pushViewController(vc, animated: true)
    }


}

extension WBDemoViewController{
    override func setUpUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "消息", target: self, action: #selector(toMsg))
    }
}
