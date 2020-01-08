//
//  WBOAuthViewController.swift
//  Weib_Demo
//
//  Created by SanDisk on 2019/12/12.
//  Copyright © 2019 SanDisk. All rights reserved.
//

import UIKit
import SVProgressHUD

class WBOAuthViewController: UIViewController {
    
    private lazy var webView = UIWebView()
    
    override func loadView() {
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        btn.setTitle("消失", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        view.addSubview(btn)
        btn.addTarget(self, action: #selector(dis), for: .touchUpInside)
        
        //加载授权页面
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(WBAppID)&redirect_uri=\(WBRedirectURI)"
        guard let url = URL(string: urlString),  let request:URLRequest? = URLRequest(url: url) else {return}
        webView.frame = view.frame
        webView.delegate = self
        webView.scrollView.isScrollEnabled = false
        webView.loadRequest(request!)
        
    }
    @objc func dis() {
        print("消失")
        SVProgressHUD.dismiss()
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension WBOAuthViewController:UIWebViewDelegate {
    
    /// webView将要家在请求
    /// - Parameters:
    ///   - webView: webview
    ///   - request: 要加载的请求
    ///   - navigationType: 导航类型
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
            
        print("加载请求--\(request.url?.absoluteString)")
        
        print("导航类型--\(navigationType)")
        
        if request.url?.absoluteString.hasPrefix(WBRedirectURI) == false {
            return true
        }
        //拿到返回的授权码
        if request.url?.query?.hasPrefix("code=") == false {
            print("取消授权")
            return true
        }else{
            print("登录成功")
            print("授权码", request.url?.query?["code=".endIndex...])
            let code = request.url?.query?["code=".endIndex...] ?? ""
            WBNetworkManager.shared.getAccessToken(code: String(code), completion: {(isSuccessed) in
                if !isSuccessed {
                    SVProgressHUD.show(withStatus: "网络请求失败")
                }else{
                    //发送登录成功消息 -- 不关心有没有监听
                    NotificationCenter.default.post(name: NSNotification.Name(WBUserLoginSuccessedNotification), object: nil)
                    
                    self.dis()
                }
            })
            SVProgressHUD.dismiss()
//            self.dismiss(animated: true, completion: nil)
        }
        
        return false
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
}
