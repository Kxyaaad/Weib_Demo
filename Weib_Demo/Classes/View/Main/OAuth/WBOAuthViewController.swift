//
//  WBOAuthViewController.swift
//  Weib_Demo
//
//  Created by SanDisk on 2019/12/12.
//  Copyright © 2019 SanDisk. All rights reserved.
//

import UIKit

class WBOAuthViewController: UIViewController {
    
    private lazy var webView = UIWebView()
    
    override func loadView() {
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //加载授权页面
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(WBAppID)&redirect_url=\(WBRedirectURI)"
        guard let url = URL(string: urlString),  let request = URLRequest(url: url) else {return}
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
