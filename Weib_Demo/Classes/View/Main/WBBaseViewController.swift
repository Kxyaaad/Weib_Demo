//
//  WBBaseViewController.swift
//  Weib_Demo
//
//  Created by SanDisk on 2019/10/14.
//  Copyright © 2019 SanDisk. All rights reserved.
//

import UIKit

class WBBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        // Do any additional setup after loading the view.
    }
    
}

extension WBBaseViewController {
    @objc func setUpUI() {
        view.backgroundColor = UIColor.cz_random()
    }
}
 
